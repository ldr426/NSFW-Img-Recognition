import os
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
from PicDetection import PicDetection
from .forms import UserForm, RegisterForm
from pic import models
import hashlib
import uuid
from django.utils import timezone
picDetection = PicDetection()


def index(request):
    """index界面"""
    return render(request, 'index.html')


def about(request):
    """about界面"""
    return render(request, 'about.html')


def register(request):
    """注册新用户"""
    if request.session.get('is_login', None):
        # 登录状态不允许注册
        return HttpResponseRedirect(reverse('pic:index'))
    if request.method == 'POST':
        # 显示空的注册表单
        register_form = RegisterForm(request.POST)
        message = "验证码错误！"
        if register_form.is_valid():  # 获取数据
            username = register_form.cleaned_data['username']
            password1 = register_form.cleaned_data['password1']
            password2 = register_form.cleaned_data['password2']
            if password1 != password2:  # 判断两次密码是否相同
                message = "两次输入的密码不同！"
                return render(request, 'register.html', locals())
            else:
                same_name_user = models.User.objects.filter(username=username)
                if same_name_user:  # 用户名唯一
                    message = '用户已经存在，请重新选择用户名！'
                    return render(request, 'register.html', locals())
                # 当一切都OK的情况下，创建新用户
                # 生成uuid并且去掉其中的 "-"
                uid = ''.join(str(uuid.uuid4()).split('-'))
                password = hash_code(password1)  # 使用加密密码
                new_user = models.User.objects.create(uid=uid, username=username, password=password)
                request.session['register_name'] = username
                # 转跳到登录界面
                return HttpResponseRedirect(reverse('pic:login'))
    register_form = RegisterForm()
    return render(request, 'register.html', locals())


def login(request):
    """用户登录"""
    if request.session.get('is_login', None):
        return render(request, 'index.html')
    if request.method == 'POST':
        login_form = UserForm(request.POST)
        message = "所有字段都必须填写！"
        if login_form.is_valid():   # 用户名密码都不为空
            username = login_form.cleaned_data['username']
            password = login_form.cleaned_data['password']
            try:
                # 此处，因为username不是主键，如出现相同username，存在漏洞...
                user = models.User.objects.get(username=username)
                if user.password == hash_code(password):
                    request.session['is_login'] = True
                    request.session['user_id'] = user.uid
                    request.session['user_name'] = user.username
                    # 如果用户名是admin，则跳转到管理员界面
                    if user.username == 'admin':
                        return render(request, 'admin.html')
                    # 如果是其他用户名，则跳转到index页面
                    else:
                        return HttpResponseRedirect(reverse('pic:index'))
                else:
                    message = "密码不正确！"
            except:
                message = "用户名不存在！"
        return render(request, 'login.html', {'message': message, 'login_form': login_form})
    login_form = UserForm()
    return render(request, 'login.html', {'login_form': login_form})


def admin_user(request):
    """
    用户管理界面
    :param request:
    :return:
    """
    users = models.User.objects.all()
    return render(request, 'admin_user.html', locals())


def admin_history(request):
    """
    历史管理界面
    :param request:
    :return:
    """
    historys = models.historyPath.objects.all()
    return render(request, 'admin_history.html', locals())


def admin_user_del(request, uid):
    """
    删除用户
    :param request:
    :return:
    """
    user = models.User.objects.get(uid=uid)
    # 删除该用户，同时也会删除该用户下的历史记录
    user.delete()
    # 重新查询后刷新页面
    users = models.User.objects.all()
    return render(request, 'admin_user.html', locals())


def admin_history_del(request, id):
    """
    历史管理界面
    :param request:
    :return:
    """
    history = models.historyPath.objects.get(id=id)
    # 删除这条记录
    history.delete()
    # 重新查询后刷新页面
    historys = models.historyPath.objects.all()
    return render(request, 'admin_history.html', locals())


def logout(request):
    """注销用户"""
    if not request.session.get('is_login', None):
        # 如果未登录，也就没有登出一词
        return render(request, 'login.html')
    request.session.flush()
    return HttpResponseRedirect(reverse('pic:index'))


def to_pic_detection(request):
    """
    转跳到图片检测页面
    :param request:
    :return:
    """
    if request.session.get('is_login', None):
        return render(request, 'PicDetection.html')
    else:
        return HttpResponseRedirect(reverse('pic:login'))  # 自动跳转到登录页面


@csrf_exempt
def file_upload(request):
    """
    用于处理上传文件
    思路：
        1.上传多个文件时，将文件存放在以username/uuid命名的文件夹中
        2.将uuid和c_time存入数据库中，每一次识别会产生一个uuid
        3.遍历该文件夹，识别图片结果
    :param request:
    :return:
    """
    if request.method == 'POST':
        upload_file = request.FILES.get('file')
        filename = upload_file.name
        username = request.session.get('user_name')
        file_uid = ''.join(str(uuid.uuid4()).split('-'))
        if request.session.get("file_uid"):
            file_uid = request.session.get("file_uid")
        else:
            request.session['file_uid'] = file_uid
        dir_path = './upload/{0}/{1}/{2}'.format(username, file_uid, filename)
        default_storage.save(dir_path, ContentFile(upload_file.read()))  # 保存分片到本地
    return HttpResponse('PicDetection.html', locals())


@csrf_exempt
def file_detect(request):
    """
    识别用户单次上传的所有图片中是否含有非法图片
    :param request:
    :return:
    """
    username = request.session.get('user_name')
    file_uid = request.session.get('file_uid')
    path = './upload/{0}/{1}'.format(username, file_uid)
    # 获取当前用户的uid
    user = models.User.objects.get(username=username)
    # 传入新上传文件的路径，遍历该路径下所有的文件，即将本次上传的图片统一识别
    results = picDetection.getResultListFromDir(path)
    # 用于测试的数据
    # results = [0.7, 0.9, 0.3]
    # 此处删除session中的file_uid
    del request.session['file_uid']
    # 此处阈值可以调节，阈值越大，检测越严格，初始设置为0.6
    contain = False
    count = 0   # 非法图片的数量
    print(results)
    for res in results:
        if res < 0.75:
            print("包含非法图片")
            count += 1
            contain = True
        else:
            print("不包含非法图片")
    result = '识别失败'
    if contain:
        result = '包含{}张非法图片'.format(count)
    else:
        result = '不包含非法图片'

    # 将新增加的上传记录存入数据库
    models.historyPath.objects.create(uid=user, path=path, c_time=timezone.now(), result=result)
    # 将识别结果存入session
    request.session['contain'] = contain
    request.session['count'] = count
    return HttpResponse('to_result')


def to_result(request):
    """
    转跳到识别结果页面
    :param request:
    :return:
    """
    contain = request.session.get('contain')
    count = request.session.get('count')
    return render(request, 'result.html', locals())


def show_history(request):
    """
    查询图片识别历史记录
    :param request:
    :return:
    """
    uid = request.session.get('user_id')
    path = models.historyPath.objects.filter(uid=uid)
    return render(request, 'history.html', locals())


def hash_code(s, salt='mysite'):  # 加点盐
    """
    密码加存储
    :param s:
    :param salt:
    :return:
    """
    h = hashlib.sha256()
    s += salt
    h.update(s.encode())  # update方法只接收bytes类型
    return h.hexdigest()
