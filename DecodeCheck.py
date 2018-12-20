#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: DecodeCheck.py
@Time: 2018/11/30 9:24 AM
@Description:
"""
import DecodeProcess

fName_decode_ad = 'dct/decode_results/text_gmm/lms_3gram/version3_sf/decode_results_4AD.mlf'
fName_standard_ad = 'dct/standard/standard_ad_v4.mlf'

fName_decode = 'dct/decode_results/text_gmm/lms_3gram/version3_sf/elder_decode_results.mlf'
fName_standard = 'dct/standard/standard_all4M_addSF.mlf'


def standardMLF(filename, module_list = ['SF']):
    mlf = list()
    with open(filename, encoding='gbk') as f:
        lines = f.readlines()
    for line in lines:
        if '#!MLF!#' in line:
            continue
        if line.startswith("\""):
            name = line[1:-2].split('.')[0]
            # print(name)
            if name.split('_')[6] in module_list:
                mlf.append(name)
                # print(name)
    return mlf


if __name__ == '__main__':
    decode_results = standardMLF(fName_decode)
    standard = standardMLF(fName_standard)
    diff = [x for x in decode_results if x not in standard]
    for d in diff:
        print(d)

