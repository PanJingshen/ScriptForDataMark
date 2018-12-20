# SF 模块
# AN3_  常见动物名称
# PN_ 中国三级地名
# FN_  常见水果名

# 三元

ngram-count -text ../../corpora/version4SF/AN3_.txt -order 1 -lm ../lms/elder1gram_AN.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder1gram_AN.LOG
ngram-count -text ../../corpora/version4SF/PN3_.txt -order 1 -lm ../lms/elder1gram_PN.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder1gram_PN.LOG
ngram-count -text ../../corpora/version4SF/train_L_SF_v3_.txt -order 1 -lm ../lms/elder1gram_L_SF.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder1gram_L_SF.LOG
ngram-count -text ../../corpora/version4SF/FN_.txt -order 1 -lm ../lms/elder1gram_FN.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder1gram_FN.LOG




# test ppl

ngram -debug 2 -lm ../lms/elder1gram_AN.gz -order 1 -ppl ../../corpora/version4SF/test_L_SF_v3_.txt > ../ppl/AN_1gram.ppl
ngram -debug 2 -lm ../lms/elder1gram_FN.gz -order 1 -ppl ../../corpora/version4SF/test_L_SF_v3_.txt > ../ppl/FN_1gram.ppl
ngram -debug 2 -lm ../lms/elder1gram_PN.gz -order 1 -ppl ../../corpora/version4SF/test_L_SF_v3_.txt > ../ppl/PN_1gram.ppl
ngram -debug 2 -lm ../lms/elder1gram_L_SF.gz -order 1 -ppl ../../corpora/version4SF/test_L_SF_v3_.txt > ../ppl/SF_1gram.ppl

# 插值

# 1. 提取条件概率

cat ../ppl/PN_1gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PN_1gram.st
cat ../ppl/AN_1gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/AN_1gram.st
cat ../ppl/FN_1gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/FN_1gram.st
cat ../ppl/SF_1gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SF_1gram.st


# 2. 计算权重
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt.weights + ../streams/PN_1gram.st + ../streams/AN_1gram.st + ../streams/FN_1gram.st  + ../streams/SF_1gram.st >& ../streams/intplt.LOG


../streams/PN_1gram.st   0.0528356812
../streams/AN_1gram.st   0.0656372764
../streams/FN_1gram.st   0.0162939232
../streams/SF_1gram.st   0.8652331192

# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0656372764 ../lms/elder1gram_AN -i 0.0162939232 ../lms/elder1gram_FN -i 0.8652331192 ../lms/elder1gram_L_SF ../../scripts/58k.chinese.ori.wlist ../lms/elder1gram_PN  ../lms/elder1gram_Merge >& ../lms/elder1gram_Merge.LOG

# 3gram => 2gram
#ngram -order 2 -lm /mnt/shareEx/panjingshen/ElderVoice/LM/EV3gram_v3/lms/elder3gram_Merge_prune.gz -write-lm /mnt/shareEx/panjingshen/ElderVoice/LM/EV2gram_v3/lms/elder2gram_Merge_prune.gz


ngram -debug 2 -lm ../lms/elder1gram_Merge.gz -order 1 -ppl ../../corpora/version4SF/test_L_SF_v3_.txt > ../ppl/Merge_1gram.ppl


#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text
# -i 0.0964671679 ../lms/elder3gram_PD
# -i 0.0529096631 ../lms/elder3gram_KY
# -i 0.1096979347 ../lms/elder3gram_JB
# -i 0.0091402236 ../lms/elder3gram_HJ
# -i 0.4292305181 ../lms/elder3gram_L_notSR_addSF
# -i 0.0161629886 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram
# -i 0.2297880029 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram
# ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG
#

#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0783987817 ../lms/elder3gram_PD -i 0.0364961674 ../lms/elder3gram_KY -i 0.0976168964 ../lms/elder3gram_JB -i 0.0085570213 ../lms/elder3gram_HJ -i 0.5378398445 ../lms/elder3gram_L_hasSR -i 0.0184633325 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.1849658950 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge_hasSR >& ../lms/elder3gram_Merge_hasSR.LOG
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.1066724522 ../lms/elder3gram_PD -i 0.0511671312 ../lms/elder3gram_KY -i 0.1308649545 ../lms/elder3gram_JB -i 0.0123297550 ../lms/elder3gram_HJ -i 0.3718505288 ../lms/elder3gram_L_notSR -i 0.0192098333 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.2376853846 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge_notSR >& ../lms/elder3gram_Merge_notSR.LOG


#
### 用测试集+开发集的词表对插值语言模型进行缩减
#ngram -order 3 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/elder_8k.wlist -limit-vocab -lm ../lms/elder3gram_Merge.gz -write-lm ../lms/elder3gram_Merge_prune_8k.gz
#
#ngram -debug 2 -lm ../lms/elder3gram_Merge_prune_8k.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge_prune_8k.ppl
#
#
#ngram -debug 2 -lm ../lms/elder3gram_Merge_prune.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge_prune.ppl
#ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge.ppl
#ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../../corpora/version2/test_L_SF.txt > ../ppl/Merge_SF.ppl
