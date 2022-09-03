from captcha.fields import CaptchaField
from django import forms
# 用户的表单


class UserForm(forms.Form):
    username = forms.CharField(label="username", max_length=128, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': "Username"}))
    password = forms.CharField(label="password", max_length=256, widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': "Password"}))


class RegisterForm(forms.Form):
    username = forms.CharField(label="用户名", max_length=128, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': "用户名"}))
    password1 = forms.CharField(label="密码", max_length=256, widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': "密码"}))
    password2 = forms.CharField(label="确认密码", max_length=256, widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': "确认密码"}))
    captcha = CaptchaField(label='验证码')
