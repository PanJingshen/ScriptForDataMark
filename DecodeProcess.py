#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: DecodeProcess.py
@Time: 2018/10/24 3:23 PM
@Description:
"""

modules = ['PD', 'SI', 'SR', 'SS']


# filter module
state_Normal = ['N']
state_MCI = ['M']
state_AD = ['A']
state_List = ['N', 'M', 'A']


# filter module
module_List4U = ['PD', 'SI', 'SR', 'SS']
module_List4F = ['PD', 'SI', 'SR', 'SS', 'SF']
module_List4R = ['PD', 'SI', 'SS']
module_filterList = ['PN', 'PR', 'SF', 'AC', 'ST']
module_List = ['PD', 'SI', 'SR', 'SS', 'PN', 'PR', 'SF', 'AC', 'ST']


# filter number
num_filerList = []
num_List4Dev = [24, 26, 27, 28, 31, 32, 33, 34, 35, 36, 37, 38, 40, 41, 42, 45, 46, 48, 53, 56]
num_List4Test = [1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 18, 19, 21, 22, 23, 25]
num_List4Train = [43, 44, 47, 49, 50, 51, 52, 54, 57, 58, 59, 60]
num_List4MCI = [5, 15, 17, 20, 29, 30, 39, 55]
num_List4AD = [1, 2, 3, 4]
num_List = [i for i in range(1, 65)]

#
# decode_results_dev_path = 'dct/text/elder_decode_results.mlf'
# decode_results_test_path = 'dct/text_dnn/test/version2/hybrid_eval.mlf'
# decode_results_mci_path = 'dct/text_dnn/mci/version2/hybrid_eval.mlf'
# decode_results_ad_path = 'dct/decode_results/text_gmm/version3/ad/elder_decode_results.mlf'

# gmm-adapt
decode_results_dev_path = ''
decode_results_test_path = 'dct/text_gmm/version2_adapt/test/old_decode_tree128_results.mlf'
decode_results_mci_path = 'dct/text_gmm/version2_adapt/mci/old_decode_tree256_results.mlf'
decode_results_ad_path = 'dct/decode_results/text_gmm/version3_adapt/old_decode_tree2_results.mlf'
decode_results_sf_path = 'dct/decode_results/text_gmm/lms_1gram/SF_v1/elder_decode_results.mlf'

# dnn
# decode_results_dev_path = 'dct/text_dnn/dev/hybrid_eval.mlf'
# decode_results_test_path = 'dct/text_dnn/test/hybrid_eval.mlf'
# decode_results_test_addSF_path = 'dct/text_gmm/version2/elder_decode_results.mlf'
# decode_results_mci_path = 'dct/text_dnn/mci/hybrid_eval.mlf'
# decode_results_SF_path = 'sh_Decode/elder_decode_results.mlf'


decode_results_path = decode_results_ad_path
target_file_path = '/'.join(decode_results_path.split('/')[:-1]) + '/'



def get_fileName(filePath):
    """
    根据路径获得文件名（不含文件类型）
    :param filePath: str
    :return: str
    """
    return filePath.split('/')[-1].split('.')[0]

def get_fileState(filePath):
    """
    根据路径获得被试状态（Normal/MCI/AD)
    :param filePath: str
    :return: str
    """
    return filePath.split('/')[-1].split('_')[0]

def get_fileModule(filePath):
    """
    根据路径获得文件模块
    :param filePath: str
    :return: str
    """
    module =  filePath.split('/')[-1].split('_')[6]
    return module


def get_fileNum(filePath):
    """
    根据路径获得文件序号
    :param filePath: str
    :return: str
    """
    # print(filePath)
    # return int(filePath.split('/')[-1][2:5])
    return int(filePath.split('/')[-1].split('_')[1])




def getDirPath(decode_results_path):
    return '/'.join(decode_results_path.split('/')[:-1]) + '/'


def checkMLF(filePath):
    lines = ''
    with open(filePath, 'r', encoding='gbk') as f:
        lines = f.readlines()
    return True

def divideModules(filePath):
    contents = list()
    PD_contents = list()
    SI_contents = list()
    SR_contents = list()
    SS_contents = list()
    SF_contents = list()
    SIandSS_contents = list()
    list_num = 0
    with open(filePath, 'r', encoding='gbk') as f:
        for line in f.readlines():
            if 'rec' in line:
                if get_fileModule(line) == 'PD':
                    PD_contents.append(line)
                    list_num = 1
                if get_fileModule(line) == 'SI':
                    SI_contents.append(line)
                    list_num = 2
                if get_fileModule(line) == 'SR':
                    SR_contents.append(line)
                    list_num = 3
                if get_fileModule(line) == 'SS':
                    SS_contents.append(line)
                    list_num = 4
                if get_fileModule(line) == 'SF':
                    SF_contents.append(line)
                    list_num = 5
            elif '#!MLF!#' in line:
                continue
            else:
                if list_num == 1:
                    PD_contents.append(line)
                if list_num == 2:
                    SI_contents.append(line)
                if list_num == 3:
                    SR_contents.append(line)
                if list_num == 4:
                    SS_contents.append(line)
                if list_num == 5:
                    SF_contents.append(line)

    SIandSS_contents = SI_contents + SS_contents

    contents.append(PD_contents)
    contents.append(SI_contents)
    contents.append(SR_contents)
    contents.append(SS_contents)
    contents.append(SF_contents)
    contents.append(SIandSS_contents)
    return contents

def divideNum(filePath):
    contents = list()
    Dev_contents = list()
    Test_contents = list()
    MCI_contents = list()
    Train_contents = list()
    AD_contents = list()
    list_num = 0
    with open(filePath, 'r', encoding='gbk') as f:
        for line in f.readlines():
            if 'rec' in line:
                state = get_fileState(line)[-1]
                if state != 'A':
                    if get_fileNum(line) in num_List4Dev:
                        Dev_contents.append(line)
                        list_num = 1
                    if get_fileNum(line) in num_List4Test:
                        Test_contents.append(line)
                        list_num = 2
                    if get_fileNum(line) in num_List4Train:
                        Train_contents.append(line)
                        list_num = 3
                    if get_fileNum(line) in num_List4MCI:
                        MCI_contents.append(line)
                        list_num = 4
                elif state == 'A':
                    if get_fileNum(line) in num_List4AD:
                        AD_contents.append(line)
                        list_num = 5
            elif '#!MLF!#' in line:
                continue
            else:
                if list_num == 1:
                    Dev_contents.append(line)
                if list_num == 2:
                    Test_contents.append(line)
                if list_num == 3:
                    Train_contents.append(line)
                if list_num == 4:
                    MCI_contents.append(line)
                if list_num == 5:
                    AD_contents.append(line)

    contents.append(Dev_contents)
    contents.append(Test_contents)
    contents.append(Train_contents)
    contents.append(MCI_contents)
    contents.append(AD_contents)
    return contents

def divideIndividuals(filePath):
    contents = list()
    contents.append(list())
    contents.append(list())
    contents.append(list())
    contents.append(list())
    contents.append(list())
    list_num = 0
    # print(filePath)
    with open(filePath, 'r', encoding='gbk') as f:
        for line in f.readlines():
            if 'rec' in line:
                list_num = get_fileNum(line)
                contents[list_num].append(line)
            elif '#!MLF!#' in line:
                continue
            else:
                contents[list_num].append(line)

    return contents


def writeLines2File(fileName, lines, firstLine = None, encoding= 'utf-8'):
    with open(fileName, 'w', encoding=encoding) as f:
        if firstLine != None:
            # f.write(firstLine + '\n')
            f.write(firstLine + '\n')
        for line in lines:
            # f.write(line + '\n')
            f.write(line)
    return f


def divByStates(decode_results_path):
    """
    divide the Set by the states [M, N, A] and divide the Set N into dev, test, train
    :param decode_results_path: str
    :return: list
    """
    statesContents = divideNum(decode_results_path)
    Dev_path = getDirPath(decode_results_path) + 'decode_results_4Dev.mlf'
    Test_path = getDirPath(decode_results_path) + 'decode_results_4Test.mlf'
    Train_path = getDirPath(decode_results_path) + 'decode_results_4Train.mlf'
    MCI_path = getDirPath(decode_results_path) + 'decode_results_4MCI.mlf'
    AD_path = getDirPath(decode_results_path) + 'decode_results_4AD.mlf'
    writeLines2File(Dev_path, statesContents[0],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(Test_path, statesContents[1],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(Train_path, statesContents[2],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(MCI_path, statesContents[3],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(AD_path, statesContents[4],firstLine='#!MLF!#', encoding='gbk')

    diviedStatePaths = list()
    diviedStatePaths.append(Dev_path)
    diviedStatePaths.append(Test_path)
    diviedStatePaths.append(Train_path)
    diviedStatePaths.append(MCI_path)
    diviedStatePaths.append(AD_path)

    return diviedStatePaths


def divByModules(decode_results_path):
    """
    divde the Set by the Modules ['PD', 'SI', 'SR', 'SS', 'PN', 'PR', 'SF', 'AC', 'ST']
    :param decode_results_path: str
    :return: list
    """
    moduleContents = divideModules(decode_results_path)

    PD_path = decode_results_path.split('.')[0] + '_PD.mlf'
    SI_path = decode_results_path.split('.')[0] + '_SI.mlf'
    SR_path = decode_results_path.split('.')[0] + '_SR.mlf'
    SS_path = decode_results_path.split('.')[0] + '_SS.mlf'
    SF_path = decode_results_path.split('.')[0] + '_SF.mlf'
    SIandSS_path = decode_results_path.split('.')[0] + '_SIandSS.mlf'

    writeLines2File(PD_path, moduleContents[0],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(SI_path, moduleContents[1],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(SR_path, moduleContents[2],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(SS_path, moduleContents[3],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(SF_path, moduleContents[4],firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(SIandSS_path, moduleContents[5],firstLine='#!MLF!#', encoding='gbk')

    dividedModulePaths = list()
    dividedModulePaths.append(PD_path)
    dividedModulePaths.append(SI_path)
    dividedModulePaths.append(SR_path)
    dividedModulePaths.append(SS_path)
    dividedModulePaths.append(SF_path)
    dividedModulePaths.append(SIandSS_path)

    return dividedModulePaths

def div2Individuals(decode_results_path):
    """
    only can div the AD state now
    :param decode_results_path:
    :return:
    """
    # TODO
    individualContents = divideIndividuals(decode_results_path)
    # writeLines2File(decode_results_path.split('.')[0] + '_0.mlf', individualContents[0], firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(decode_results_path.split('.')[0] + '_1.mlf', individualContents[1], firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(decode_results_path.split('.')[0] + '_2.mlf', individualContents[2], firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(decode_results_path.split('.')[0] + '_3.mlf', individualContents[3], firstLine='#!MLF!#', encoding='gbk')
    writeLines2File(decode_results_path.split('.')[0] + '_4.mlf', individualContents[4], firstLine='#!MLF!#', encoding='gbk')

    diviedIndPaths = list()
    return diviedIndPaths


def initial():
    print("Choose options:")
    print("1: div By States: [M, N, A];")
    print("2: div By Modules: ['PD', 'SI', 'SF', 'SR', 'SS', 'SIandSS'];")
    print("3: div By Individuals: only for AD and only 4 num;")
    print("4: exit")


    while(True):
        choice = int(input("Your choice: "))
        if choice == 1:
            filePath = input('1. Input your filePath: ')
            statePaths = divByStates(filePath)
            for path in statePaths:
                modulePaths = divByModules(path)
            # div2Individuals(statePaths[4])
            continue
        if choice == 2:
            filePath = input('2. Input your filePath: ')
            divByModules(filePath)
            continue
        if choice == 3:
            filePath = input('3. Input your filePath: ')
            divideIndividuals(filePath)
            continue
        if choice == 4:
            exit()
        else:
            print('4. Input error.')

if __name__ == '__main__':
    initial()



