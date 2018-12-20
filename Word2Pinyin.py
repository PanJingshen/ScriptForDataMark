#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: Word2Pinyin.py
@Time: 2018/12/10 5:18 PM
@Description:
"""





from pypinyin import pinyin, lazy_pinyin, Style, phonetic_symbol

import jieba
import re
import Wlist
import Dctionary

# 带数字与声调字符表示声调的对应关系
PHONETIC_SYMBOL_DICT = phonetic_symbol.phonetic_symbol_reverse.copy()
# 匹配带声调字符的正则表达式
RE_PHONETIC_SYMBOL = re.compile(
    r'[{0}]'.format(
        re.escape(''.join(PHONETIC_SYMBOL_DICT.keys()))
    )
)
# 匹配使用数字标识声调的字符的正则表达式
RE_TONE2 = re.compile(r'([aeoiuvnm])([1-4])')
# 匹配 TONE2 中标识韵母声调的正则表达式
RE_TONE3 = re.compile(r'^([a-z]+)([1-4])([a-z]*)$')

alpha_list = ['a', 'o', 'e', 'i', 'u']
['ai', 'ei', 'ui', 'ao', 'ou', 'iu', 'ie', 'ue', 'er']
['an', 'en', 'in', 'un']
['ang', 'eng', 'ing', 'ong']

userdict = 'dct/text/version4/pinyin_dct.txt'


handy_filePath = 'dct/text/version4/handy.txt'


def replace_number_to_symbol(pinyin):
    """把数字替换为声调"""
    def _replace(match):
        symbol = match.group(0)  # 带声调的字符
        # 返回使用数字标识声调的字符
        return PHONETIC_SYMBOL_DICT[symbol]

    # 替换拼音中的带声调字符
    return RE_TONE2.sub(_replace, pinyin)



def format_pinyin(py_list):
    phones = list()
    #TODO 此处拼音
    for py in py_list:
        phones += jieba.cut(py)
    return phones

def transfer_Word2Pinyin(word):
    dct = dict()

    # 1.分词
    sq_list = jieba.cut(word, cut_all=False)
    # print([x for x in sq_list])


    # 2.拼音
    phone = list()
    for w in sq_list:
        # print('w:'+ w)
        phones = pinyin(w, style=Style.TONE2, heteronym=True)
        # print(a)
        print([w for w in phones])
        for py in phones:
            if len(py) > 1:
                return False
            for p in jieba.cut(py[0]):
                phone.append(p)

    # 3.组合

    return phone

def init():
    jieba.load_userdict(userdict)

    return

def process_handy_word(wlist):
    """
    手动处理多音字的词表
    :param wlist: list
    :return: dict
    """
    dct = dict()
    for word in wlist:
        print('\nProcessing Word=====>' + word)
        phones = list()
        isDel = False
        for char in word:
            print('Processing Char:' + char)
            pys = pinyin(char, style=Style.TONE2, heteronym=True)
            pys = pys[0]
            if len(pys) > 1:
                for x in range(len(pys)):
                    print(str(x+1) + ': ' + pys[x] + ';')
                print('0: Delete word')
                choice = int(input('Choose the pinyin of ' + char + ': '))
                if choice == 0:
                    isDel = True
                    break
                phones.append(pys[choice - 1])
            else:
                phones.append(pys[0])
            # print([x for x in phones])
        if isDel == True:
            continue
        dct[word] = [phones]

    return dct


def process_handy_word_writeFile(wlist, filePath):
    """
    手动处理多音字的词表
    :param wlist: list
    :return: dict
    """
    with open(filePath, 'a', encoding='gbk') as f:
        for word in wlist:
            print('\nProcessing Word =====> ' + word)
            phones = list()
            isDel = False
            isExit = False
            for char in word:
                pys = pinyin(char, style=Style.TONE2, heteronym=True)
                pys = pys[0]
                if len(pys) > 1:
                    print(word + ': ' + char)
                    for x in range(len(pys)):
                        print(str(x+1) + ': ' + replace_number_to_symbol(pys[x]) + ';')
                    print('0: Delete word;')
                    print('110: Exit.')

                    choice = int(input('Choose the pinyin of ' + char + ': '))
                    while(True):
                        if choice in range(1, len(pys) + 1):
                            break
                        if choice == 0:
                            isDel = True
                            break
                        elif choice == 110:
                            isExit = True
                            break
                        else:
                            choice = int(input('Choose again: '))

                    if isDel == True:
                        break
                    if isExit == True:
                        break

                    phones.append(pys[choice - 1])
                else:
                    phones.append(pys[0])
                # print([x for x in phones])
            if isDel == True:
                continue
            if isExit == True:
                break

            line = '{key:' + str(10) + '}' + ' ' + '{value}\n'
            phones = format_pinyin(phones)
            content = line.format(key=word, value=' '.join(phones))
            print(content)
            f.write(content)

    return



if __name__ == '__main__':
    init()
    # x = format_pinyin(['ni3ha2oa1', 'zhe3li3'])
    # print([a for a in x])


    # wlist = Wlist.__getWordList_FromWlist(handy_filePath)
    #
    # handy_list = list()
    # dct = dict()
    #
    # for word in wlist:
    #     transfer = transfer_Word2Pinyin(word)
    #     if transfer == False:
    #         handy_list.append(word)
    #     else:
    #         dct[word] = [transfer]
    #
    # Dctionary.printTxt(handy_list, 'dct/text/version4/handy_transfered.txt')
    # Dctionary.printDct(dct)
    # Dctionary.outputDct('dct/text/version4/handy_transfered.dct', dct)



    # ===== generate the handy transfer dct file =========
    wlist = Wlist.__getWordList_FromWlist('dct/text/version4/handy_transfered3.txt')
    dct = process_handy_word_writeFile(wlist, 'dct/text/version4/handy_transfered3.dct')


