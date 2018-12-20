#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: Dctionary.py
@Time: 2018/12/6 4:07 PM
@Description:
"""


import re
import Wlist

pattern = '^[a-z0-9]'

dct_filePath = 'dct/58k.chinese.ori.dct'
wlist_filePath = 'dct/text/version4/SF.wlist'
outputPath = 'dct/text/version4/SF.dct'
outputPath1 = 'dct/text/version4/test.dct'
handy_path = 'dct/text/version4/handy.txt'
not_in_dct_path = 'dct/text/version4/oov.txt'
pinyin_path = 'dct/text/version4/pinyin_dct.txt'


out_of_dct_list = list()
handy_list = list()
pinyin_list = list()


def get_words_from_dct(filePath):
    """
    从发音字典中获得词表
    :param filePath: str
    :return: list
    """
    words = list()
    with open(filePath, 'r', encoding='gbk') as f:
        lines = f.readlines()
        for line in lines:
            if '<' not in line:
                words.append(line.split(' ')[0])
    return words

def get_uniphone_word_list(dct_list):
    """
    得到单字单发音（非多音字）的字列表
    :param wlist: list
    :return: list
    """
    return [x for x in dct_list if len(x) == 1 and dct_list.count(x) == 1]

def get_dct_list_from_dct(dct):
    """
    从发音词典中获得词列表（不去重版本）
    :param dct: dict
    :return: list
    """
    dct_list = list()
    for key, value in dct.items():
        for x in range(len(value)):
            dct_list.append(key)
    return dct_list


def get_pylist_from_dct(dct):
    pyList = list()
    for key, value in dct.items():
        for py in value:
            pyList += py
    return list(sorted(set(pyList)))

def is_uniphone4Word(word, dct):
    """
    检测词中的字是不是只有一个发音，根据从发音词典中获得的list而不是wlist（可能删去了重复的）
    :param word: str
    :param dct_list: list
    :return: Bool
    """
    for char in word:
        if char not in dct.keys():
            # print(char + ': Warning! Not in dct.')
            out_of_dct_list.append(char)
            return False
        if len(dct[char]) > 1:
            return False
    return True


def get_dct(filePath):
    """
    读取发音词典路径，获得词典（可处理多音字）
    :param filePath: str
    :return: dict
    """
    with open(filePath, 'r', encoding='gbk') as f:
        lines = f.readlines()

        dct = dict()
        for line in lines:
            # items = line.strip().split(' ')
            items = re.split('[\t\s]', line.strip())
            word = items[0]
            phone = [x for x in items[1:] if x != '']
            if '<' not in word:
                if word in dct.keys():
                    dct[word].append(phone)
                else:
                    dct[word] = [phone]

    return dct

def generate_dct_from_wlist(wlist, dct):
    """

    :param wlist: list
    :param dct: dict
    :return: dict
    """
    new_dct = dict()
    oov_list = list()

    # 已有的word，直接添加
    for word in wlist:
        if word in dct.keys():
            new_dct[word] = dct[word]
        else:
            oov_list.append(word)

    # OOVs
    for word in oov_list:
        if is_uniphone4Word(word, dct):
            phone = get_wphone_from_dct(word, dct)
            new_dct[word] = [phone]
        else:
            handy_list.append(word)
    return new_dct


def get_wphone_from_dct(word, dct):
    """
    获得词的发音，此处词必须没有多音
    :param word: str
    :param dct: dict
    :return: list
    """
    wphone = list()
    for char in word:
        if char in dct.keys():
            wphone += dct[char][0]
    return wphone



def printDct(dct):
    """
    打印生成的字典
    :param dct: dict
    """
    for key, value in dct.items():
        print('{key}:{value}'.format(key=key, value=value))

def printTxt(list, file_path):
    with open(file_path, 'w', encoding='gbk') as f:
        f.writelines([x + '\n' for x in list])


def getMaxLength4Key(dct):
    max_length = 0
    for key, value in dct.items():
        l = len(key)
        if l > max_length:
            max_length = l
    return max_length

def outputDct(outputPath, dct):
    """
    将生成的dct保存为文件
    :param outputPath: str
    :param dct: dict
    """
    with open(outputPath, 'w', encoding='gbk') as f:
        headers = '<s>	[!SENT_START]	sil\n</s>	[!SENT_END]	sil\n'
        f.write(headers)

        max_length = getMaxLength4Key(dct)

        for key, value in dct.items():
            # 多音字输出
            for x in range(len(value)):
                line = '{key:' + str(max_length * 2) + '}' + ' ' + '{value}\n'
                f.write(line.format(key=key, value=' '.join(value[x])))

if __name__ == '__main__':
    # dct = get_dct(dct_filePath)
    # wlist = Wlist.__getWordList_FromWlist(wlist_filePath)
    # pinyin_list = get_pylist_from_dct(dct)
    # # 格式化输出需要
    # MaxLength4Key = Wlist.get_max_length(wlist)
    # new_dct = generate_dct_from_wlist(wlist=wlist, dct=dct)
    #
    # outputDct(outputPath, new_dct)
    # printTxt(handy_list, handy_path)
    # printTxt(out_of_dct_list, not_in_dct_path)

    # printTxt(pinyin_list, pinyin_path)


    # dct = get_dct('dct/text/version4/SF_v3.dct')
    #
    # wlist = Wlist.__getWordList_FromWlist('dct/text/version4/handy_transfered.txt')
    #
    # MaxLength4Key = Wlist.get_max_length(wlist)
    # handy_dct = generate_dct_from_wlist(wlist=wlist, dct=dct)
    # outputDct('dct/text/version4/SF_handy.dct', handy_dct)

    dct1 = get_dct('dct/text/version4/SF_v1.dct')
    dct2 = get_dct('dct/text/version4/SF_handy.dct')

    dct = dct1
    dct.update(dct2)
    outputDct('dct/text/version4/SF_v3.dct', dct)
    # wlist = [key for key in dct.keys()]
    # printTxt(wlist, 'dct/text/version4/SF_v1.wlist')



    #TODO 拼音检测
    # eg. zi => z i5:
    # e3 r => er3 :
    # a3 i => ai3
    # e3 i => ei3: ' ([ae])([0-9]) i ' => ' $1i$2 '
    # a3 o => ao3: ' a([0-9]) o ' => ' ao$1 '
    # qi o3 ng => q i3 o3 ng: 'i o([0-9])' => ' i$1 o$1' , tips：注意空格






