import sys
import argparse
import tensorflow.compat.v1 as tf
import io
from model import OpenNsfwModel, InputType
from PIL import Image
import numpy as np
import skimage
import skimage.io
import os


class PicDetection:

    def __init__(self):
        tf.disable_v2_behavior()
        os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
        os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
        self.model_weights_path = 'D:/PyCharmWorkSpance/PicReg/pic/data/open_nsfw-weights.npy'
        self.model = OpenNsfwModel()
        self.VGG_MEAN = [104, 117, 123]
        self.img_width, self.img_height = 224, 224

    def prepare_image(self, image):
        """
        将RGB按照BGR重新组装，然后对每一个RGB对应的值减去一定阈值
        :param image:
        :return:
        """
        H, W, _ = image.shape
        h, w = (self.img_width, self.img_height)
        h_off = max((H - h) // 2, 0)
        w_off = max((W - w) // 2, 0)
        image = image[h_off:h_off + h, w_off:w_off + w, :]
        image = image[:, :, :: -1]
        image = image.astype(np.float32, copy=False)
        image = image * 255.0
        image = image-np.array(self.VGG_MEAN, dtype=np.float32)

        image = np.expand_dims(image, axis=0)
        return image

    def getResultFromFilePathByPyModle(self, path):
        """
        加载python类型的文件检测图片
        :param path: 待检测文件的路径
        :return: 检测结果集
        """
        im = Image.open(path)
        if im.mode != "RGB":
            im = im.convert('RGB')
        imr = im.resize((256, 256), resample=Image.BILINEAR)

        fh_im = io.BytesIO()
        imr.save(fh_im, format='JPEG')
        fh_im.seek(0)

        image = (skimage.img_as_float(skimage.io.imread(fh_im))
                 .astype(np.float32))
        final = self.prepare_image(image)
        tf.reset_default_graph()
        with tf.Session() as sess:
            input_type = InputType[InputType.TENSOR.name.upper()]
            self.model.build(weights_path=self.model_weights_path, input_type=input_type)
            sess.run(tf.global_variables_initializer())

            predictions = sess.run(self.model.predictions, feed_dict={self.model.input: final})
            return predictions[0][0]

    def getResultListFromDir(self, path):
        """
        遍历待检测的文件夹下所有文件
        :return:
        """
        list = os.listdir(path)
        # 识别的结果
        res = []
        for i in range(0, len(list)):
            if (list[i] != ".DS_Store" and list[i] != ".localized"):
                res.append(self.getResultFromFilePathByPyModle(os.path.join(path, list[i])))
        return res

