#!/usr/bin/env python 
# -*- coding:utf-8 -*-
import re


# 输入文件路径
path_input = "si_wodeketangwang.txt"
# 输出文件路径
path_output = "si_wodeketangwang_output.txt"

# 匹配格式，仅保留对话行，"；"& "："
pattern0 = re.compile('（(.*?)）')
# 匹配格式，去除"（）"内容/中文括号
pattern1 = '（(.*?)）'
# 匹配格式，去除"【】"前内容
pattern2 = '【(.*?)】'
# 匹配格式，去除无标点符号的行
pattern3 = ''
# 匹配格式，去除"（）"内容
pattern4 = '\n.*?看图(.*?一).*?'





if __name__ == "__main__":

    file_o = open(path_output, 'w', encoding='utf-8')
    with open(path_input, 'r') as file_i:
        data = file_i.read()
        data1 = re.subn(pattern1, '', data)
        data2 = re.subn(pattern2, '', str(data1))
        # list = re.findall(pattern2, data)
        print(list)
        file_o.write(str(data2))


    file_o.close()