from django.urls import path, re_path
from . import views

app_name = 'pic'
urlpatterns = [
    path('', views.index, name='index'),
    path('index', views.index, name='index'),
    path('about', views.about, name='about'),
    path('register', views.register, name='register'),
    path('login', views.login, name='login'),
    path('logout', views.logout, name='logout'),
    path('to_pic_detection', views.to_pic_detection, name='to_pic_detection'),
    path('file_upload', views.file_upload, name='file_upload'),
    path('file_detect', views.file_detect, name='file_detect'),
    path('to_result', views.to_result, name='to_result'),
    path('show_history', views.show_history, name='show_history'),
    path('admin_user', views.admin_user, name='admin_user'),
    path('admin_history', views.admin_history, name='admin_history'),
    path('admin_user_del/<uid>', views.admin_user_del, name='admin_user_del'),
    path('admin_history_del/<id>', views.admin_history_del, name='admin_history_del'),
]
