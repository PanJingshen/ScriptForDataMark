#!/usr/bin/env python 
# -*- coding:utf-8 -*-

SI_FC_path = '/Users/panjingshen/workspace/ScriptForDataMark/dct/SI_FC.mlf'
PD_FC_path = '/Users/panjingshen/workspace/ScriptForDataMark/dct/PD_FC.mlf'
OR_FC_path = '/Users/panjingshen/workspace/ScriptForDataMark/dct/OR_FC.mlf'
TTL_FC_path = '/Users/panjingshen/workspace/ScriptForDataMark/dct/TTL_FC.mlf'
TRL_FC_path = '/Users/panjingshen/workspace/ScriptForDataMark/dct/TRL_FC.mlf'


wlist_filePath = '/Users/panjingshen/workspace/ScriptForDataMark/dct/58k.chinese.ori.wlist'

def get_wordSet(filePath):
    wlist = list()
    with open(filePath, encoding='gbk') as f:
        lines = f.readlines()
        for line in lines:
            wlist.append(line[:-1])
    wlist.remove('<s>')
    wlist.remove('</s>')
    # print(wlist)
    wSet = set(wlist)
    return wSet

def get_FCSet(filePath):
    wlist = list()
    with open(filePath, encoding='gbk') as f:
        text = f.read()
        words = text.split(' ')
        for word in words:
            wlist.append(word)
    wSet = set(wlist)
    # print(wSet)
    wSet.remove('')
    wSet.remove('\n')
    return wSet

def compareSet(FCSet, wordSet):
    for word in FCSet:
        if word not in wordSet:
            print(word)
    return

def checkOOV(SI_FC_path, wlist_filePath):

    fileName = SI_FC_path.split('/')[-1]
    print('Checked File: ' + fileName + '\n' )
    wordSet = get_wordSet(wlist_filePath)
    FCSet = get_FCSet(SI_FC_path)
    compareSet(FCSet, wordSet)
    return


if __name__ == '__main__':
    checkOOV(SI_FC_path, wlist_filePath)
    checkOOV(PD_FC_path, wlist_filePath)
    checkOOV(OR_FC_path, wlist_filePath)
    checkOOV(TTL_FC_path, wlist_filePath)
    checkOOV(TRL_FC_path, wlist_filePath)