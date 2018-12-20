#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: Cropora4SF.py
@Time: 2018/12/5 7:05 PM
@Description:
"""
import addS

PN_ = 'dct/text/version4/PlaceName.txt'
CC_ = 'dct/text/version4/CountryandCapital.txt'
outputFileName = 'dct/text/version4/PN3.txt'

def getList(fileName):
    with open(fileName, 'r', encoding='gbk') as f:
        lines = f.readlines()
    return lines

def combineList(list1, list2):
    return sorted(list(set(list1 + list2)))

if __name__ == '__main__':
    combinedList = combineList(getList(PN_), getList(CC_))


    with open(outputFileName, 'w', encoding='gbk') as f:
        f.writelines(combinedList)
