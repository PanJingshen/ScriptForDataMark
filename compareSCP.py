#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: compareSCP.py
@Time: 2018/10/18 下午7:46
@Description:
"""
# dev
old_scp_path = 'sh_Decode/Elder_dev_v1.scp'
new_scp_path = 'Elder_dev_v2.scp'
# test
# old_scp_path = 'sh_Decode/Elder_test_v1.scp'
# new_scp_path = 'Elder_test_v3.scp'

def get_scps(path):
    list_1 = list()
    with open(path, 'r') as f:
        for line in f.readlines():
            list_1.append(line)
    return list_1

def compareSCP(list1, list2):
    compare_list = list()
    for scp in list1:
        if scp.split('.')[0] not in [line.split('.')[0] for line in list2]:
            compare_list.append(scp)
            print(scp + '\n')
    return compare_list


if __name__ == '__main__':
    old_scps = get_scps(old_scp_path)
    new_scps = get_scps(new_scp_path)

    print('in old not in new: \n')
    compareSCP(old_scps, new_scps)

    print('in new not in old: \n')
    scps = compareSCP(new_scps, old_scps)
    with open('dev_add_scp.scp', 'w') as f:
        f.writelines(scps)
