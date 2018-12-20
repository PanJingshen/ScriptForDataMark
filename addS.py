#!/usr/bin/env python 
# -*- coding:utf-8 -*-
filePath = 'dct/text/version4/PN3.txt'


def addS(filePath):
    dirPath = '/'.join(filePath.split('/')[:-1])
    fileName = filePath.split('/')[-1].split('.')[0]
    print(dirPath)
    print(fileName)
    lines = list()
    with open(filePath, 'r', encoding='gbk') as input:
        for line in input.readlines():
            lines.append('<s> ' + line.strip() + ' </s>\n')

    with open(dirPath + '/' + fileName + '_.txt', 'w', encoding='gbk') as output:
        output.writelines(lines)


if __name__ == '__main__':
    addS(filePath)