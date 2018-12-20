#!/usr/bin/env python 
# -*- coding:utf-8 -*-
from typing import List
from praatio import tgio
from DataCheck import get_data_list
import re
import shutil
import os
import wave

# ========================== Paragrams ================================

# ------------------------ Edit Paragrams --------------------------
path = '/Users/panjingshen/SIAT/OldVoice/DataMark/data_mark/' \
       'N_053_guolaixiang_M_20180723_mono/' \
       'N_053_guolaixiang_M_20180723_mono_PD/' \
       'N_053_guolaixiang_M_20180723_mono_PD_01.TextGrid'

# data_path = '/Users/panjingshen/SIAT/OldVoice/label_9.25/normal/'
# data_path = '/Users/panjingshen/Downloads/MCI/'
# data_path = '/Users/panjingshen/Downloads/ljm-mark/'
# data_path = '/Users/panjingshen/SIAT/OldVoice/DataMark/data_mark/'
# data_path = '/Users/panjingshen/SIAT/OldVoice/anno_data copy/'
data_path = '/Users/panjingshen/Downloads/AD/'

dir_path = '/Users/panjingshen/workspace/ScriptForDataMark/label_20181029/'
# dir_path = 'label_mci_v1/'
# mark_path = 'label_temp_v1/'


# mark_path = '/Users/panjingshen/SIAT/OldVoice/label_9.25/normal/'
mark_path = '/Users/panjingshen/workspace/ScriptForDataMark/label_20181029/'
# mark_path = '/Users/panjingshen/workspace/ScriptForDataMark/label_mci_v1/'
# mark_path = '/Users/panjingshen/workspace/ScriptForDataMark/label_temp_v2/'

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
num_List4AllexptTrain = [x for x in num_List if x not in num_List4Train]


# content_filterList = ['(())', '[V', '[D', '【', '】', '（', '）', '~', '[']
char_filterList = ['(())', '[V', '[D', '【', '】', '（', '）', '~', '[', 'pa', 'da', 'ka']


# generate label.txt
L_version = '_v4'
L_fileName4Test = 'test_L' + L_version + '.txt'
L_fileName4Test_PD = 'test_L_PD' + L_version + '.txt'
L_fileName4Test_SI = 'test_L_SI' + L_version + '.txt'
L_fileName4Test_SR = 'test_L_SR' + L_version + '.txt'
L_fileName4Test_SS = 'test_L_SS' + L_version + '.txt'
L_fileName4Test_SF = 'test_L_SF' + L_version + '.txt'
L_fileName4Train = 'train_L'+ L_version +'.txt'
L_fileName4Train_SF = 'train_L_SF' + L_version + '.txt'
L_fileName4Dev = 'dev_L'+ L_version +'.txt'
L_fileName4Dev_SF = 'dev_L_SF' + L_version + '.txt'
L_fimeName4All = 'dct/L_all' + L_version + '.txt'
L_fileName = L_fileName4Test


# generate MarkCheck.txt
mark_check_version = '_v3'
# mark_checkList = ['[' + chr(i) for i in range(97, 123)] # 小写字母
mark_checkList = ['?']
mark_check_fileName = 'MarkCheck' + mark_check_version + '.txt'

# generate standard.mlf
mlf_version = '_v1'
mlf_filterList = char_filterList
mlf_fileName = 'standard' + mlf_version + '.mlf'

mlf_version4Dev = '_dev_v4'
mlf_fileName4Dev = 'standard' + mlf_version4Dev + '.mlf'

mlf_version4Test = '_test_v4'
mlf_fileName4Test = 'standard' + mlf_version4Test + '.mlf'

mlf_version4MCI = '_mci_v4'
mlf_fileName4MCI = 'standard' + mlf_version4MCI + '.mlf'

mlf_version4AD = '_ad_v4'
mlf_fileName4AD = 'standard' + mlf_version4AD + '.mlf'


# generate Elder.scp
scp_version = '_v4'
scp_fileName = 'Elder' + scp_version + '.scp'

scp_version4Dev = '_dev'+ scp_version
scp_fileName4Dev = 'Elder' + scp_version4Dev + '.scp'

scp_version4Test = '_test'+ scp_version
scp_fileName4Test = 'Elder' + scp_version4Test + '.scp'

scp_version4MCI = '_mci'+ scp_version
scp_fileName4MCI = 'Elder' + scp_version4MCI + '.scp'

scp_version4AD = '_ad'+ scp_version
scp_fileName4AD = 'Elder' + scp_version4AD + '.scp'

scp_version4SF = '_SF'+ scp_version
scp_fileName4SF = 'Elder' + scp_version4SF + '.scp'
scp_fileName4SF4AD = 'Elder' + scp_version4SF + '_ad' + '.scp'

scp_fileName4SFnotTrain = 'Elder' + scp_version4SF + '_notTrain' + '.scp'

# feat path
feat4Dev = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-old-dev/data/old_dev/pap/feat/'
feat4Test = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-old-test/data/old_test/pap/feat/'
feat4MCI = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-mci/data/old_mci/pap/feat/'
feat4AD = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-old-ad/data/old_ad/pap/feat/'

feat4SF = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-old-sf/data/old_sf/pap/feat/'
feat4ST = '.pap=/mnt/shareEx/shizhuqing/yanquanlei/gen-feat-old-st/data/old_all/pap/feat/'

# generate StartEndCheck.txt
se_check_version = '_v1'
se_fileName = 'StartEndCheck' + se_check_version + '.txt'


# ------------------------ Stable Paragrams --------------------------





# ========================== File Process ================================

# ------------------------ Path Access --------------------------
def get_filePaths(dir):
    """
    获取文件夹下所有目录
    :param dir: str
    :return: list
    """
    filePaths = list()
    fileNames = os.listdir(dir)
    for fileName in fileNames:
        if '.TextGrid' in fileName:
            filePaths.append(dir + fileName)
    return filePaths

def get_filePaths1(dir):
    """
    获取文件夹下所有目录
    :param dir: str
    :return: list
    """
    filePaths = list()
    fileNames = os.listdir(dir)
    os.path.walk()
    for fileName in fileNames:
        if '.TextGrid' in fileName:
            filePaths.append(dir + fileName)
    return filePaths


# ------------------------ Path Filter --------------------------

def ste_filter_paths(file_list, state_list=state_List):
    """
    根据状态过滤文件列表，在文件列表的通过
    :param file_list: list
    :param sta_list: list
    :return: list
    """
    file_filtered_list = list()
    for file_path in file_list:
        sta = get_fileState(file_path)
        if sta in state_list:
            file_filtered_list.append(file_path)
    return file_filtered_list

def num_filter_paths(file_list, num_list=num_List):
    """
    根据序号列表过滤文件列表，在文件列表的通过
    :param file_list: list
    :param num_list: list
    :return: list
    """
    file_filtered_list = list()
    for path in file_list:
        num = get_fileNum(path)
        if num in num_list:
            file_filtered_list.append(path)
    return file_filtered_list





def mdl_filter_paths(file_list, module_list=module_List):
    """
    根据模块过滤文件列表
    :param file_list: list
    :param module_list: list
    :return: list
    """
    file_filtered_list = list()
    for file_path in file_list:
        module = get_fileModule(file_path)  # 文件名：N_053_guolaixiang_M_20180723_mono_PD
        if module in module_list:
            file_filtered_list.append(file_path)
    return file_filtered_list


def pathFilter(path_list, ste_list=state_List, num_list=num_List, mdl_list=module_List):
    path_list = ste_filter_paths(path_list, ste_list)
    # print('ste Filter: ' + str(path_list))
    path_list = num_filter_paths(path_list, num_list)
    # print('Num Filter: ' + str(path_list))
    path_list = mdl_filter_paths(path_list, mdl_list)
    # print('Mdl Filter: ' + str(path_list))
    return path_list


# ------------------------ Path Process -----------------------

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


# ------------------------ File Write -----------------------
def writeLines2File(fileName, lines, firstLine = None, encoding= 'utf-8'):
    with open(fileName, 'w', encoding=encoding) as f:
        if firstLine != None:
            # f.write(firstLine + '\n')
            f.write(firstLine + '\n')
        for line in lines:
            f.write(line + '\n')
            # f.write(line)
    return f


# ------------------------ File Copy -----------------------
def copyFile2Dir(file_path, dir_path):
    """
    拷贝文件到对应目录下
    :param file_path: str, 原文件目录
    :param dir_path: str, 目标目录, eg. 'dir/'
    """
    fileName = get_fileName(file_path)
    shutil.copyfile(file_path, dir_path + fileName + '.TextGrid')


def copyFiles2Dir(file_pathList, dir_path):
    """
    批量拷贝文件到对应目录下
    :param file_pathList: 原文件目录列表
    :param dir_path: str, 目标目录, eg. 'dir/'
    """
    for file_path in file_pathList:
        copyFile2Dir(file_path, dir_path)


# ========================== Data Access ================================
# ------------------lable.txt --------------------
# *********** 根据单个文件名获取label内容 *******************
def get_labelList_from_textgrid(path):
    tg = tgio.openTextgrid(path)
    firstTier = tg.tierDict[tg.tierNameList[0]]
    labelList = [[entry[0], entry[1], entry[2]] for entry in firstTier.entryList]
    return labelList

# *********** 根据文件名列表获取label内容 *******************
def get_labelList_from_textgrids(path_list):
    labelList = list()
    for path in path_list:
        labels = get_labelList_from_textgrid(path)
        for label in labels:
            labelList.append(label)
    return labelList


def get_labels(dir_path=mark_path, states=state_List, modules=module_List, nums=num_List, fileName=L_fileName):
    """
    获取标注内容，生成test.txt or train.txt
    :param dir_path: list
    :param modules: list
    :param nums: list
    :param fileName: str
    """
    data_dirs = get_filePaths(dir_path)
    data_dirs.sort()
    # print('Before filter:' + str(data_dirs))
    data_dirs = pathFilter(data_dirs, ste_list=states, mdl_list=modules, num_list=nums)
    # print('After filter:' + str(data_dirs))
    label_list = get_labelList_from_textgrids(data_dirs)
    label_list = filter_sentence(label_list, filterList=mlf_filterList)
    label_list.sort()

    with open(fileName, 'w', encoding='gbk') as f:
        for label in label_list:
            f.write(label[2] + '\n')



# ========================== Data Check ================================


def filter_sentence(labelList, filterList=mlf_filterList):
    """
    过滤有中文字符的句子
    :param labelList: list
    :param filterList: list
    :return: list
    """
    filtered_labelList = removePinyin(labelList)
    new_labelList= list()
    for label in filtered_labelList:
        if has_illegal_char(label[2], filterList) != True:
            print(label)
            new_labelList.append(label)

    return new_labelList

def has_illegal_char(checked_str, check_list=mlf_filterList):
    for char in check_list:
        if char in checked_str:
            return True
    return False


def removePinyin(labelList):
    new_labelList = list()
    pattern = re.compile(r'\[([a-z0-9])+\]')
    for label in labelList:
        new_labelList.append([label[0], label[1], label[2]])
    for new_label in new_labelList:
        for sound in ['[' + chr(i) for i in range(97, 123)]:
            if sound not in new_label[2]:
                continue
            else:
                new_label[2] = re.sub(pattern, '', new_label[2])
    return new_labelList

# ------------------------ StartEndCheck.log -----------------------
# *********** 检测 末尾音频是否留静默段 *******************
def is_blankEnd(filePath):
    # print(get_fileName(filePath))
    tg = tgio.openTextgrid(filePath)
    firstTier = tg.tierDict[tg.tierNameList[0]]
    maxTime = int(float(tg.maxTimestamp) * 100)
    maxEndLabelTime = int(float(firstTier.entryList[-1][-2]) * 100)

    # print('End——' + get_fileName(filePath) + ': ' + str(maxTime) + ' ' + str(maxEndLabelTime))
    if maxTime == maxEndLabelTime:
        return True
    return False


# *********** 检测 开始音频是否留静默段 *******************
def is_blankStart(filePath):
    tg = tgio.openTextgrid(filePath)
    firstTier = tg.tierDict[tg.tierNameList[0]]
    minTime = int(float(tg.minTimestamp) * 100)
    minStartLabelTime = int(float(firstTier.entryList[0][0]) * 100)
    # print(str(maxTime) + ' ' + str(minStartLabelTime))
    if minTime == minStartLabelTime:
        return True
    return False


# *********** 检测末尾音频是否留静默段 *******************
def check_ends(dir_path=mark_path, modules=module_List, nums=num_List):
    data_dirs = get_filePaths(dir_path)
    data_dirs = mdl_filter_paths(data_dirs, modules)
    data_dirs = num_filter_paths(data_dirs, nums)
    data_dirs.sort()
    ends_list = list()
    for dir in data_dirs:
        if is_blankEnd(dir):
            ends_list.append(dir.split('/')[-1])
    return ends_list


# *********** 检测末尾音频是否留静默段 *******************
def check_starts(dir_path=mark_path, modules=module_List, nums=num_List):
    data_dirs = get_filePaths(dir_path)
    data_dirs = mdl_filter_paths(data_dirs, modules)
    data_dirs = num_filter_paths(data_dirs, nums)
    data_dirs.sort()
    starts_list = list()
    for dir in data_dirs:
        if is_blankStart(dir):
            starts_list.append(dir.split('/')[-1])
    return starts_list


# *********** 合并starts & ends dir列表 *******************
def combineSEDir(starts_list, ends_list):
    combine_list = list()
    for dir in starts_list:
        if dir in ends_list:
            combine_list.append(dir)

    new_list = list()

    for dir in starts_list:
        if dir not in combine_list:
            new_list.append(dir + ': Start')
    for dir in ends_list:
        if dir not in combine_list:
            new_list.append(dir + ': End')
    for dir in combine_list:
        new_list.append(dir + ': Start/End')

    return new_list


def checkSE(dir_path=mark_path, modules=module_List, nums=num_List, fileName=se_fileName):
    ends_list = check_ends()
    starts_list = check_starts()
    list = combineSEDir(starts_list, ends_list)
    writeLines2File(fileName, list)




# ------------------------ MarkCheck.txt -----------------------


def get_LabelList(filePath):
    tg = tgio.openTextgrid(filePath)
    firstTier = tg.tierDict[tg.tierNameList[0]]
    labelList = [[entry[0], entry[1], entry[2]] for entry in firstTier.entryList]
    return labelList


def isContentAbnormal(content, checkList):
    for check in checkList:
        if check in content:
            return True
    return False


def checkContents(path_list, content_checkList):
    check_list = list()
    for filePath in path_list:
        labelList = get_LabelList(filePath)
        for i in range(len(labelList)):
            if isContentAbnormal(labelList[i][-1], content_checkList):
                check_list.append((get_fileName(filePath), labelList[i][-1]))
    return check_list


def checkMark(dir_path=mark_path, states=state_List, modules=module_List, nums=num_List, fileName = mark_check_fileName):
    """

    :param dir_path: str
    :param modules: list
    :param nums: list
    :param fileName: str
    :return:
    """
    data_dirs = get_filePaths(dir_path)
    data_dirs = pathFilter(data_dirs, ste_list=states, mdl_list=modules, num_list=nums)

    check_list = checkContents(data_dirs, mark_checkList)
    check_list = set(check_list)
    check_list = list(check_list)
    check_list.sort()

    firstLine = '#Check Mark#'  + '\n' \
                'Checked Dir: ' + dir_path + '\n' \
                + 'Checked Label: ' + str(mark_checkList) + '\n'
    writeLines2File(fileName, [check[0] + '\n' + check[1] + '\n' for check in check_list],
                    firstLine)
    return


# ========================== SCP Process ================================

# ------------------------ Elder.scp -----------------------

# *********** 获取格式化数字 *******************
# 12位数，前方补0
# 单位：纳秒
#
def get_format_strNum_12(num):
    dup_num = 10e7
    return str(round(num * dup_num)).zfill(12)


# *********** 获取格式化数字 *******************
# 小数保留两位
# 单位：
#
def get_format_strNum_2(num):
    return str(round(num * 100))


# *********** 根据文件名列表获取label内容 *******************
def get_scp(filePath, fileName_1):
    scp_list = list()
    labelList = get_LabelList(filePath)
    fileName = get_fileName(filePath)
    filtered_labelList = filter_sentence(labelList)
    for i in range(len(filtered_labelList)):
        start_time = filtered_labelList[i][0]
        end_time = filtered_labelList[i][1]
        print('fileName: ' + fileName_1)
        if 'test' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4Test + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
            continue
        elif 'dev' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4Dev + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
            continue
        elif 'mci' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4MCI + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
        elif 'ad' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4AD + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
        elif 'SF' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4SF + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
        elif 'ST' in fileName_1:
            scp = fileName + '_' + get_format_strNum_12(start_time) + '_' + get_format_strNum_12(end_time) + \
                  feat4ST + fileName + '.pap[' + get_format_strNum_2(start_time) + ',' + get_format_strNum_2(end_time) + ']'
        scp_list.append(scp)
    return scp_list


# *********** 根据文件名列表获取scp内容 *******************
def get_scpList_from_textgrids(path_list, fileName=None):
    scpList = list()
    for path in path_list:
        scps = get_scp(path, fileName)
        for scp in scps:
            scpList.append(scp)
    return scpList


def get_scps(dir_path=mark_path, states=state_List, modules=module_List, nums=num_List, fileName = scp_fileName):
    """
    data_dirs = pathFilter(data_dirs, ste_list=states, num_list=nums, mdl_list=modules)
    :param dir_path: str
    :param states: List[str]
    :param modules: List[str]
    :param nums: List[int]
    :param fileName: str
    """
    data_dirs = get_filePaths(dir_path)

    data_dirs = pathFilter(data_dirs, ste_list=states, num_list=nums, mdl_list=modules)

    scps = get_scpList_from_textgrids(data_dirs, fileName)
    scps.sort()

    writeLines2File(fileName, scps)


# ========================== MLF Process ================================
# ------------------standard.mlf --------------------




# *********** 根据文件名列表获取mlf内容 *******************
def get_mlfList_from_textgrids(path_list):
    stdList = list()
    for path in path_list:
        stds = get_mlf(path)
        for std in stds:
            stdList.append(std)
    return stdList




# *********** 根据文件名列表获取stardard.mlf *******************
def get_mlf(filePath):
    std_list = list()
    tg = tgio.openTextgrid(filePath)
    firstTier = tg.tierDict[tg.tierNameList[0]]
    labelList = [[entry[0], entry[1], entry[2]] for entry in firstTier.entryList]
    fileName = get_fileName(filePath)
    print('fileName: ' + fileName)
    filtered_labelList = filter_sentence(labelList)
    for i in range(len(filtered_labelList)):
        # print(filtered_labelList[i][2])
        std = '\"' + fileName + '_' + get_format_strNum_12(filtered_labelList[i][0]) + '_' + get_format_strNum_12(
            filtered_labelList[i][1]) + '.lab\"\n'
        for word in filtered_labelList[i][2]:
            std += word + '\n'
        std += '.'
        # print(std)
        std_list.append(std)

    return std_list

def get_mlfs(dir_path=mark_path, states=state_List, modules=module_List, nums=num_List, fileName=mlf_fileName):
    """
    生成standard.mlf
    :param dir_path: list
    :param modules: list
    :param nums: list
    :param fileName: str
    """
    data_dirs = get_filePaths(dir_path)
    data_dirs = pathFilter(data_dirs, ste_list=states, num_list=nums, mdl_list=modules)

    stds = get_mlfList_from_textgrids(data_dirs)
    stds.sort()

    with open(fileName, 'w', encoding='gbk') as f:
        f.write('#!MLF!#\n')
        for line in stds:
            f.write(line + '\n')


# ========================== Main ================================
if __name__ == '__main__':
    # get_scps(states=state_Normal, nums=num_List4Dev, modules=module_List4U, fileName=scp_fileName4Dev)
    # get_mlfs(states=state_Normal, nums=num_List4Dev, modules=module_List4U, fileName=mlf_fileName4Dev)

    # get_scps(states=state_Normal, nums=num_List4Test, modules=module_List4U, fileName=scp_fileName4Test)
    # get_mlfs(states=state_Normal, nums=num_List4Test, fileName=mlf_fileName4Test)

    # get_scps(states=state_MCI, nums=num_List4MCI, modules=module_List4U, fileName=scp_fileName4MCI)
    # get_mlfs(states=state_MCI, nums=num_List4MCI, fileName=mlf_fileName4MCI)

    # get_scps(states=state_AD, nums=num_List4AD, modules=module_List4U, fileName=scp_fileName4AD)
    # get_scps(states=state_List, nums=num_List4AllexptTrain, modules=['SF'], fileName=scp_fileName4SFnotTrain)
    get_scps(states=state_List, nums=num_List, modules=['SF'], fileName=scp_fileName4SF)
    # get_mlfs(states=state_AD, nums=num_List4AD, fileName=mlf_fileName4AD)


    # get_mlfs(states=state_List, nums=num_List, modules=module_List4F, fileName='standard_all4M_addSF.mlf')

    # get_labels(states=state_List, modules=module_List, nums=num_List, fileName=L_fimeName4All)
    # get_labels(states=state_Normal, modules=module_List4U, nums=num_List4Dev, fileName=L_fileName4Dev)
    # get_labels(states=state_Normal, modules=module_List4R, nums=num_List4Train, fileName=L_fileName4Train)

    # get_labels(states=state_Normal, modules=module_List4F, nums=num_List4Train, fileName='L_addSF.txt')
    # get_labels(states=state_Normal, modules=['SF'], nums=num_List4Dev, fileName=L_fileName4Dev_SF)

    # get_labels(states=state_Normal, modules=['SF'], nums=num_List4Test, fileName=L_fileName4Test_SF)
    # get_labels(states=state_Normal, modules=['PD'], nums=num_List4Test, fileName=L_fileName4Test_PD)
    # get_labels(states=state_Normal, modules=['SI'], nums=num_List4Test, fileName=L_fileName4Test_SI)
    # get_labels(states=state_Normal, modules=['SR'], nums=num_List4Test, fileName=L_fileName4Test_SR)
    # get_labels(states=state_Normal, modules=['SS'], nums=num_List4Test, fileName=L_fileName4Test_SS)


    # get_scps(states=state_List, nums=num_List, modules=['SF'], fileName=scp_fileName4SF)



    # checkSE()
    # checkMark()

    # 复制所有文件到同一文件夹下

    # data_dirs = get_data_list(data_path)
    # copyFiles2Dir(data_dirs, dir_path)
