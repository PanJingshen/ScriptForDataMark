

# 三元
#ngram-count -text ../../corpora/version2/train_SI.txt -order 3 -lm ../lms/elder3gram_SI.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_SI.LOG
#ngram-count -text ../../corpora/version2/train_PD.txt -order 3 -lm ../lms/elder3gram_PD.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_PD.LOG

#ngram-count -text ../../corpora/version2/train_KY.txt -order 3 -lm ../lms/elder3gram_KY.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_KY.LOG
#ngram-count -text ../../corpora/version2/train_JB.txt -order 3 -lm ../lms/elder3gram_JB.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_JB.LOG
#ngram-count -text ../../corpora/version2/train_HJ.txt -order 3 -lm ../lms/elder3gram_HJ.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_HJ.LOG

#ngram-count -text ../../corpora/version2/train_L_hasSR.txt -order 3 -lm ../lms/elder3gram_L_hasSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L_hasSR.LOG
#ngram-count -text ../../corpora/version2/train_L_notSR.txt -order 3 -lm ../lms/elder3gram_L_notSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L_notSR.LOG

ngram-count -text ../../corpora/version2/train_L_notSR_addSF.txt -order 3 -lm ../lms/elder3gram_L_notSR_addSF.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L_notSR_addSF.LOG


# test ppl

ngram -debug 2 -lm ../lms/elder3gram_SI.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/SI_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_PD.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/PD_3gram.ppl

ngram -debug 2 -lm ../lms/elder3gram_KY.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/KY_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_JB.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/JB_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_HJ.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/HJ_3gram.ppl

ngram -debug 2 -lm ../lms/elder3gram_L_notSR_addSF.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/L_notSR_addSF_3gram.ppl

ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/tdt4_3gram.ppl
ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram.gz -order 3 -ppl ../../corpora/version2/test_L_addSF.txt > ../ppl/gigaword_3gram.ppl

# 插值

# 1. 提取条件概率

cat ../ppl/SI_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SI_3gram.st
cat ../ppl/PD_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PD_3gram.st

cat ../ppl/KY_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/KY_3gram.st
cat ../ppl/JB_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/JB_3gram.st
cat ../ppl/HJ_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/HJ_3gram.st

cat ../ppl/L_notSR_addSF_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L_notSR_addSF_3gram.st

cat ../ppl/tdt4_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/tdt4_3gram.st
cat ../ppl/gigaword_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/gigaword_3gram.st



# 2. 计算权重
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt_notSR_addSF.weights + ../streams/SI_3gram.st + ../streams/PD_3gram.st + ../streams/KY_3gram.st  + ../streams/JB_3gram.st  + ../streams/HJ_3gram.st + ../streams/L_notSR_addSF_3gram.st + ../streams/tdt4_3gram.st + ../streams/gigaword_3gram.st >& ../streams/intplt_notSR_addSF.LOG


../streams/SI_3gram.st   0.0566035011
../streams/PD_3gram.st   0.0964671679
../streams/KY_3gram.st   0.0529096631
../streams/JB_3gram.st   0.1096979347
../streams/HJ_3gram.st   0.0091402236
../streams/L_notSR_addSF_3gram.st   0.4292305181
../streams/tdt4_3gram.st   0.0161629886
../streams/gigaword_3gram.st   0.2297880029

# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0964671679 ../lms/elder3gram_PD -i 0.0529096631 ../lms/elder3gram_KY -i 0.1096979347 ../lms/elder3gram_JB -i 0.0091402236 ../lms/elder3gram_HJ -i 0.4292305181 ../lms/elder3gram_L_notSR_addSF -i 0.0161629886 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.2297880029 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG

# 3gram => 2gram
#ngram -order 2 -lm /mnt/shareEx/panjingshen/ElderVoice/LM/EV3gram_v3/lms/elder3gram_Merge_prune.gz -write-lm /mnt/shareEx/panjingshen/ElderVoice/LM/EV2gram_v3/lms/elder2gram_Merge_prune.gz




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
## 用测试集+开发集的词表对插值语言模型进行缩减
ngram -order 3 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/elder_8k.wlist -limit-vocab -lm ../lms/elder3gram_Merge.gz -write-lm ../lms/elder3gram_Merge_prune_8k.gz

ngram -debug 2 -lm ../lms/elder3gram_Merge_prune_8k.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge_prune_8k.ppl


ngram -debug 2 -lm ../lms/elder3gram_Merge_prune.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge_prune.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../../corpora/version2/test_L.txt > ../ppl/Merge.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../../corpora/version2/test_L_SF.txt > ../ppl/Merge_SF.ppl
