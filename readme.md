# NSFW Recognition Sys

Established a Multi-user Online NSFW Image Detection Website based on Djangoframework. 

Implemented Yahoo’s Open NSFW Model using TensorFlow and scikit-image.

## NSFW Pic Detection

## Not suitable for work classifier

Detecting offensive / adult images is an important problem which researchers have tackled for decades. With the evolution of computer vision and deep learning the algorithms have matured and we are now able to classify an image as not suitable for work with greater precision.

Defining NSFW material is subjective and the task of identifying these images is non-trivial. Moreover, what may be objectionable in one context can be suitable in another. For this reason, the model we describe below focuses only on one type of NSFW content: pornographic images. The identification of NSFW sketches, cartoons, text, images of graphic violence, or other types of unsuitable content is not addressed with this model.

Since images and user generated content dominate the internet today, filtering nudity and other not suitable for work images becomes an important problem. In this repository we opensource a Caffe deep neural network for preliminary filtering of NSFW images.

## Model Usage for Yahoo NSFW Model

- The network takes in an image and gives output a probability (score between 0-1) which can be used to filter not suitable for work images. Scores < 0.2 indicate that the image is likely to be safe with high probability. Scores > 0.8 indicate that the image is highly probable to be NSFW. Scores in middle range may be binned for different NSFW levels.
- Depending on the dataset, usecase and types of images, we advise developers to choose suitable thresholds. Due to difficult nature of problem, there will be errors, which depend on use-cases / definition / tolerance of NSFW. Ideally developers should create an evaluation set according to the definition of what is safe for their application, then fit a [ROC](https://en.wikipedia.org/wiki/Receiver_operating_characteristic) curve to choose a suitable threshold if they are using the model as it is.
- ***Results can be improved by [fine-tuning](http://caffe.berkeleyvision.org/gathered/examples/finetune_flickr_style.html)*** the model for your dataset/ use case / definition of NSFW. We do not provide any guarantees of accuracy of results. Please read the disclaimer below.
- Using human moderation for edge cases in combination with the machine learned solution will help improve performance.

## Process

| Method in Class PicDetection         | Description                                                  |
| ------------------------------------ | ------------------------------------------------------------ |
| prepare_image(image)                 | Reassemble RGB according to BGR, and then subtract a certain threshold from the value corresponding to each RGB |
| getResultFromFilePathByPyModle(path) | Load python type files to detect images                      |
| getResultListFromDir(path)           | Traverse all files in the folder to be detected              |



## View and Template (in MVT Django)

| View              | Related Template   | Description                                                  |
| ----------------- | ------------------ | ------------------------------------------------------------ |
| Index             | index.html         | Index page                                                   |
| about             | about.html         | About page                                                   |
| register          | register.html      | Register a new user                                          |
| login             | login.html         | User login                                                   |
| admin_user        | admin_user.html    | User management page                                         |
| admin_history     | admin_history.html | History management page                                      |
| admin_user_del    | admin_user.html    | Delete users                                                 |
| admin_history_del | admin_history.html | History management interface                                 |
| logout            | login.html         | Logout user                                                  |
| to_pic_detection  | PicDetection.html  | Jump to image detection page                                 |
| file_upload       | PicDetection.html  | Used to process uploaded files: <br/>When uploading multiple files, store the files in a folder named username/uuid; Store uuid and c_time in the database, and each recognition will generate a uuid; Traverse the folder to recognize pictures result |
| file_detect       | PicDetection.html  | Identify whether all images uploaded by a user contain NSFW images |
| to_result         | result.html        | Jump to the recognition result page                          |
| show_history      | history.html       | Query image recognition history                              |
| hash_code         | login.html         | Password storage (Add salt)                                  |



## Model (in MVT Django)

### User Table:

| Name     | Type             |
| -------- | ---------------- |
| uid      | models.CharField |
| username | models.CharField |
| password | models.CharField |

### historyPath Table:

| Name   | Type                 |
| ------ | -------------------- |
| id     | models.IntegerField  |
| uid    | models.ForeignKey    |
| path   | models.CharField     |
| c_time | models.DateTimeField |
| result | models.CharField     |



## Settings

### URL Configurationurls	

The `urlpatterns` list routes URLs to views. For more information please see [here](https://docs.djangoproject.com/en/3.1/topics/http/urls/).

Examples:

Function views

1. Add an import:  from my_app import views
2. Add a URL to urlpatterns:  path('', views.home, name='home')

Class-based views

1. Add an import:  from other_app.views import Home
2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')

Including another URLconf

1. Import the include() function: from django.urls import include, path
2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))

### WSGI / ASGI Configurationurls

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see [here](https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/)

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see [here](https://docs.djangoproject.com/en/3.1/howto/deployment/asgi/)


### Other Settings

Quick-start development settings - unsuitable for production, see [here](https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/)

Database, see [here](https://docs.djangoproject.com/en/3.1/ref/settings/#databases)

Password validation, see [here](https://docs.djangoproject.com/en/3.1/ref/settings/#auth-password-validators)

Internationalization, see [here](https://docs.djangoproject.com/en/3.1/topics/i18n/)

Static files (CSS, JavaScript, Images) ,see [here](https://docs.djangoproject.com/en/3.1/howto/static-files/)