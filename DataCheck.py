#!/usr/bin/env python 
# -*- coding:utf-8 -*-


import os
import wave

# **************** Paragrams *******************

file_path_mark = '/Users/panjingshen/SIAT/OldVoice/DataMark/data_mark/'  # 标注数据根文件夹路径
file_path_data = '/Users/panjingshen/SIAT/OldVoice/DataMark/data/'  # 音频数据根文件夹路径


# path2 = r'/Users/panjingshen/SIAT/OldVoice/DataMark/data/N_047_xiyonghui_F_20180719_mono/N_047_xiyonghui_F_20180719_mono_SI/N_047_xiyonghui_F_20180719_mono_SI_01.wav'
# filepath = '/Users/panjingshen/SIAT/OldVoice/DataMark/data_mark/N_003_wangyuhe_F_20180703_mono/'
# filepath = '/Users/panjingshen/SIAT/OldVoice/DataMark/'

# *********** 获取一级子目录 *******************

def get_first_dir(file_path):
    filenames = os.listdir(file_path)
    file_list = list('')

    for filename in filenames:
        # print('filename1:' + filename)
        if '.DS_Store' not in filename:  # 除去非文件夹类型名称
            # print('filename2:' + filename)
            file_list.append(file_path + filename)
        else:
            continue
    return file_list


# *********** 获取二级子目录 *******************
def get_sub_dir(file_list):
    subfile_list = list()

    for file_name in file_list:
        subfile_names = os.listdir(file_name + '/')
        for subfile_name in subfile_names:
            if '.DS_Store' not in subfile_name:
                subfile_list.append(file_name + '/' + subfile_name)

    return subfile_list

    # print([dataname for dataname in subfile_list])


# *********** 获取三级子目录（data文件名） *******************
def get_data_dir(subfile_list):
    data_list = list()

    for subfile_name in subfile_list:
        data_names = os.listdir(subfile_name + '/')
        for data_name in data_names:
            if '_mono' in data_name:
                data_list.append(subfile_name + '/' + data_name)
    return data_list

    # print([dataname for dataname in data_list])

# ******************* 获取data文件名的列表 ****************************
def get_data_list(filepath):
    print(filepath)
    firstDirs = get_first_dir(filepath)
    # print(firstDirs)
    subDirs = get_sub_dir(firstDirs)
    dataDirs = get_data_dir(subDirs)
    return dataDirs

# ********************** 数据检测 ****************************

def check_data(data_list):
    d_list = list()  # 含有'[D]'的文件名列表
    v_list = list()  # 含有'[V]'的文件名列表
    u_list = list()  # 含有'(())'的文件名列表

    for data_name in data_list:
        with open(data_name) as file:
            content = file.read()
            if '[D' in content:
                d_list.append(data_name.split('/')[-1])
            if '[V' in content:
                v_list.append(data_name.split('/')[-1])
            if '(())' in content:
                u_list.append(data_name.split('/')[-1])

    # d_text = set(d_list)
    d_text = [dataname for dataname in d_list]
    print(d_text)


# ********************** 获取音频时长 ****************************

def get_wav_duration(path):
    with wave.open(path, 'rb') as f:
        rate = f.getframerate() # 帧率
        frames = f.getnframes() # 帧数
        duration = frames / float(rate) # 时长 = 帧数/帧率
        print('file path:'+ path + '\n时长：' +str(duration))
    return duration

# ********************** 获取音频时长 ****************************
def get_total_duration(path_list):
    total_duration = 0
    for data_dir in path_list:
        total_duration += get_wav_duration(data_dir)
    # check_data(dataDirs)
    # print('Total duration: ' + str(total_duration / 60) + ' min.')
    print('Total duration: ' + str(total_duration) + ' s.')
    return total_duration

# ********************** 写入到文件夹 ****************************
def toTxt(text):
    file_name = ''
    with open(file_name, 'w') as f:
        f.write(text)





# ********************** 主函数 ****************************
if __name__ == '__main__':
    markDirs = get_data_list(file_path_mark)
    dataDirs = get_data_list(file_path_data)

    get_total_duration(dataDirs)  # 对象：音频数据

    #check_data(markDirs)  # 对象：文本数据

