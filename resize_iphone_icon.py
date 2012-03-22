#!/usr/bin/python
import os
import sys
import shutil
from subprocess import call
import Image
import argparse

def resizeImage(image, width, height):
    resized = image.resize((width, height), Image.ANTIALIAS)
    resized.save(os.path.join(os.getcwd(), "Icon"+str(width)+".png"))

def processFile(fileName):

    if not os.path.exists(fileName):
        os.makedirs(dirName)

    im1 = Image.open(fileName)

    resizeImage(im1, 320, 320)
    resizeImage(im1, 144, 144)
    resizeImage(im1, 114, 114)
    resizeImage(im1, 72, 72)
    resizeImage(im1, 64, 64)
    resizeImage(im1, 58, 58)
    resizeImage(im1, 57, 57)
    resizeImage(im1, 48, 48)
    resizeImage(im1, 29, 29)

parser = argparse.ArgumentParser(description='Resize iPhone Icon')
parser.add_argument('filename', metavar='Filename', help='The filename to resize')
args = parser.parse_args()

print args.filename
filename = os.path.join(os.getcwd(), args.filename)

processFile(filename)
