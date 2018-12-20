#!/usr/bin/env python 
# -*- coding:utf-8 -*-
"""
@version: 0.1
@Aurthor: Jingshen PAN
@File: scripy4AN.py
@Time: 2018/12/5 3:51 PM
@Description:
"""

from urllib import request
from urllib import error
from bs4 import BeautifulSoup
import chardet
import re
import sys


# *************************** 自定义参数 *******************************
# 爬虫网站的网址前部
url = "http://www.aidongwu.net/mingcheng"
# 爬虫网站的网址后部
suffix = "."+"html"
# 文章列表的页面个数
# pageNumber = 15
# 页面编码格式
encoding = ""

fileName = 'dct/text/version4/AN3.txt'


# *************************** 以下尽量不要更改 *******************************
# req = request.Request(url)
pattern1 = '(?:style=\"font-size: 16px;\">)(.*?)(?:</a>)'

# 3.模拟成浏览器并爬取对应的网页 谷歌浏览器
headers = {'User-Agent',
           'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36'}
opener = request.build_opener()
opener.addheaders = [headers]

url_article_href_list = []


# 获得文章的超链接列表
def get_Name_List(url):
    print('Trying to get URLs of Article:'+ url)
    name_list = list()
    try:
        req = request.Request(url)
        response = request.urlopen(req)
        html = response.read()
        charset = chardet.detect(html)
        # print(charset)
        html = html.decode(charset['encoding'])
        content_href = re.findall(pattern1, html, re.I)
        for x in content_href:
            # x = x[13:-1]
            print(x)
            name_list.append(x+'\n')
    except error.HTTPError as e:
        print(e.code)

    return name_list

if __name__ == "__main__":


    nameList = get_Name_List(url)

    with open(fileName, 'w', encoding='utf8') as f:
        f.writelines(nameList)


