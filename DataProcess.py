#!/usr/bin/env python 
# -*- coding:utf-8 -*-

import re

file_path = 'si_wodeketangwang.txt'
path_output = 'si_wodeketangwang_output.txt'

# 匹配格式，仅保留对话行，"；"& "："
pattern0 = re.compile('（(.*?)）')
# 匹配格式，去除"（）"内容/中文括号
pattern1 = '（(.*?)）'
# 匹配格式，去除"【】"前内容
pattern2 = '【(.*?)】'
# 匹配格式，去除无标点符号的行
pattern3 = ''
# 匹配格式，去除"（）"内容
pattern4 = ''

def del_char(text):
    text.replace('&nbsp;', '')
    text.replace(r'\u3000', '')
    # text.replace(r'\n', '\n')
    # text.replace('', '')
    # text.replace()

    # re.compile(pattern1)
    # str.replace()

def opera_process():
    return


if __name__ == '__main__':

    text = ''
    with open(file_path, 'r', encoding='utf8') as f:
        text = f.read()
    del_char(text)



    with open(path_output,'w', encoding='utf8') as f_o:
        text2 = list()
        data1 = re.subn(pattern2, '', text)
        print(str(data1))
            # text2.append(str(data1))

        f_o.writelines(str(data1))
    # data2 = re.subn(pattern2, '', str(data1))