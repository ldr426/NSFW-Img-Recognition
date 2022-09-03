from django.db import models

# Create your models here.


class User(models.Model):
    """user用户表"""
    uid = models.CharField(max_length=255, unique=True, primary_key=True)
    username = models.CharField(max_length=255)
    password = models.CharField(max_length=255)


    def __str__(self):
        return self.uid

    class Meta:
        db_table = 'user'


class historyPath(models.Model):
    """historyPath表"""
    id = models.IntegerField(unique=True, primary_key=True)
    uid = models.ForeignKey(to="User", to_field="uid", on_delete=models.CASCADE)
    # uid = models.CharField(max_length=255)
    path = models.CharField(max_length=255)
    c_time = models.DateTimeField()
    result = models.CharField(max_length=255)

    # 与user建立一对多的关系,外键字段建立在多的一方


    def __str__(self):
        return self.id

    class Meta:
        db_table = 'historyPath'
