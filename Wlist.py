#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: Wlist.py
@Time: 2018/12/5 10:18 PM
@Description:
"""

trainPath = 'dct/text/version4/train_L_SF_v3_.txt'
ANPath = 'dct/text/version4/AN3_.txt'
FNPath = 'dct/text/version4/FN_.txt'
PNPath = 'dct/text/version4/PN3_.txt'
wlistPath = 'dct/text/elder_8k.wlist'


outputPath = 'dct/text/version4/SF_v3.wlist'

pathList = [trainPath, ANPath, FNPath, PNPath, wlistPath]


standardPath = 'sh_Decode/58k.chinese.ori.wlist'
checkedPath = outputPath


def __getWordList_FromCorpora(filePath):
    words = list()
    with open(filePath, 'r', encoding='gbk') as f:
        for line in f.readlines():
            words += line.split(' ') [1:-1]
    return words

def __getWordList_FromWlist(filePath):
    with open(filePath, 'r', encoding='gbk') as f:
        return [x.strip() for x in f.readlines() if '<' not in x]

def __getWordList_FromDct(filePath):
    wlist = list()
    with open(filePath, 'r', encoding='gbk') as f:
        for line in f.readlines():
            word = line.split(' ')[0]
            if '<' not in word:
                # print(word)
                wlist.append(word)
    return wlist

def get_max_length(wlist):
    max = 0
    for s in wlist:
        if len(s) > max:
            max = len(s)
    return max

def getWordList(filePath):
    if filePath.endswith('.txt'):
        return __getWordList_FromCorpora(filePath)
    if filePath.endswith('.wlist'):
        # TODO 不完美，需要更改
        return [x.strip() for x in __getWordList_FromWlist(filePath) if len(x.strip()) == 1]
    else:
        print("filePath Error.")
        return

def formatWordList(wlist):
    return sorted(list(set(wlist)))

def checkOOV(standardPath, checkedPath):
    s_wlist = __getWordList_FromWlist(standardPath)
    c_wlist = __getWordList_FromWlist(checkedPath)
    oov_list = __getOOVs(s_wlist, c_wlist)
    print('Count:' + str(len(oov_list)))
    for x in oov_list:
        print(x)
    return oov_list

def __getOOVs(standard_wlist, checked_wlist):
    return [x for x in checked_wlist if x not in standard_wlist]

def generateWlist(pathList, outputPath):
    """

    :param pathList: list
    :param outputPath: str
    """
    all_list = list()
    for path in pathList:
            all_list += getWordList(path)
    final_list = formatWordList(all_list)
    output_wlist(final_list, outputPath)



def output_wlist(wlist, outputPath):

    # add headers
    wlist.insert(0, '<s>')
    wlist.insert(1, '</s>')

    with open(outputPath, 'w', encoding='gbk') as f:
        f.writelines('\n'.join(wlist))

def initial():
    print("Choose options:")
    print("1: generate wlist according to the path list;")
    print("2: check OOVs;")
    # print("3: div By Individuals: only for AD and only 4 num;")
    print("4: exit")


    while(True):
        choice = int(input("Your choice: "))
        if choice == 1:
            generateWlist(pathList, outputPath)
            continue
        if choice == 2:
            checkOOV(standardPath, checkedPath)
            continue
        if choice == 3:
            continue
        if choice == 4:
            exit()
        else:
            print('4. Input error.')


if __name__ == '__main__':
    # initial()
    wlist = __getWordList_FromDct('dct/text/version4/SF_v3.dct')
    output_wlist(wlist, 'dct/text/version4/SF_v3.wlist')