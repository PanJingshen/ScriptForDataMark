#首先，将要处理的所有语料放入一个文件中
cat /mnt/shareEx/panjingshen/ElderVoice/LM/version2/material/*.txt > alltxt

#-------------------------------------------------------------------
#预处理
#1.去除不必要的空格，例如去除中文文字之间的空格；去除前数字后英文之间的空格；
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/preremove.pl alltxt > pjs001

#2.替换所有不规则的字母和数字形式            （准备文件：letter_digit_replace_list）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/letter_digit_replace_list pjs001 pjs002

#3.替换不正确的单位形式
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/endReplaceUnit.pl pjs002 > pjs003

#4.去除括号  
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/removeBracket.pl pjs003 > pjs004


#5.按照句号分行
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/enterperiod.pl pjs004 > pjs005

#6.去除英文或是数字较多的单句
#perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/RemoveSymbolMoreSentence.pl pjs005 > Norm_Sentence_corpus00 （正常句子）
#perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/PrintSymbolMoreSentence.pl pjs005 > Symbol_More_corpus00    （含有较多字母或数字的句子）

#--------------------------------------------------------------------
#分类

#将文本分为两类 perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/classification.pl Norm_Sentence_corpus00 allChinesecorpus00 othercorpus00
#纯中文单句：allChinesecorpus00
#中文以及带有符号的单句：othercorpus00

#--------------------------------------------------------------------

#文本替换
 
#1.替换为正规的符号表示                     （准备文件：find_and_replace.pl     all_instead_replace_list）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/all_instead_replace_list pjs005 pjs006 
#2.替换双单位表示，例如m/s                  （准备文件：find_and_replace.pl  find_replace.list）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/find_replace.list pjs006 pjs007
#3.替换单个单位表示，例如s                  （准备文件：find_and_replace.pl  single_find_replace.list）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/single_find_replace.list pjs007 pjs008
#4.处理一些特殊情况                         （准备文件：all_houchuli.pl）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/all_houchuli.pl pjs008 > pjs009
#5.替换阿拉伯数字                           （准备文件：number2Ch.pl）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/number2Ch.pl pjs009 > pjs010
#6.将一些符号用空格代替                     （准备文件：space_find_and_replace.pl  newall_space_replace_list）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/space_find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/newall_space_replace_list pjs010 pjs011
#7.去除特殊符号                             （准备文件：remove_find_and_replace.pl）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/remove_find_and_replace.pl /mnt/shareEx/panjingshen/ElderVoice/LM/script/all_remove_replace_list pjs011 pjs012
#8.再次判断，去掉数字和英文较多的句子
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/RemoveSymbolMoreSentence.pl pjs012 > END_CH_Norm_corpus00
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/PrintSymbolMoreSentence.pl pjs012 > pjs013
#9.将所有的数字替换为中文，包括英文缩写中的数字
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/number2ChV2.pl pjs013 > pjs014
#10.将多余的空格去掉                        （准备文件：onlyremovespace.pl）
perl /mnt/shareEx/panjingshen/ElderVoice/LM/script/onlyremovespace.pl pjs014 > pjs015
#11.分词
/mnt/share/hushoukang/bin/HTokenise -D -V -T 1 -A /mnt/shareEx/srf/commen/dcts/58k.dct pjs015 pjs015FC.mlf
#12.加<s>
perl /mnt/share/yanquanlei/commen/scripts/getLMTrainDataFromWordMLF.pl corpus/transcription_word_train.mlf > corpus/train.txt

#/mnt/shareEx/srf/ 模型工具都在里面
