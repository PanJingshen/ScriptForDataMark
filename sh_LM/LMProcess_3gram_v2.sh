

# 三元
ngram-count -text ../../corpora/version1/train_SI.txt -order 3 -lm ../lms/elder3gram_SI.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_SI.LOG
ngram-count -text ../../corpora/version1/train_PD.txt -order 3 -lm ../lms/elder3gram_PD.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_PD.LOG

ngram-count -text ../../corpora/version1/train_KY.txt -order 3 -lm ../lms/elder3gram_KY.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_KY.LOG
ngram-count -text ../../corpora/version1/train_JB.txt -order 3 -lm ../lms/elder3gram_JB.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_JB.LOG
ngram-count -text ../../corpora/version1/train_HJ.txt -order 3 -lm ../lms/elder3gram_HJ.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_HJ.LOG

ngram-count -text ../../corpora/version1/train_L_hasSR.txt -order 3 -lm ../lms/elder3gram_L_hasSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L_hasSR.LOG
ngram-count -text ../../corpora/version1/train_L_notSR.txt -order 3 -lm ../lms/elder3gram_L_notSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L_notSR.LOG


# test ppl

ngram -debug 2 -lm ../lms/elder3gram_SI.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/SI_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_PD.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/PD_3gram.ppl

ngram -debug 2 -lm ../lms/elder3gram_KY.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/KY_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_JB.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/JB_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_HJ.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/HJ_3gram.ppl

ngram -debug 2 -lm ../lms/elder3gram_L_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/L_hasSR_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_L_notSR.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/L_notSR_3gram.ppl

ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/tdt4_3gram.ppl
ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/gigaword_3gram.ppl

# 插值

# 1. 提取条件概率

cat ../ppl/SI_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SI_3gram.st
cat ../ppl/PD_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PD_3gram.st

cat ../ppl/KY_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/KY_3gram.st
cat ../ppl/JB_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/JB_3gram.st
cat ../ppl/HJ_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/HJ_3gram.st

cat ../ppl/L_hasSR_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L_hasSR_3gram.st
cat ../ppl/L_notSR_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L_notSR_3gram.st

cat ../ppl/tdt4_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/tdt4_3gram.st
cat ../ppl/gigaword_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/gigaword_3gram.st



# 2. 计算权重
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt_notSR.weights + ../streams/SI_3gram.st + ../streams/PD_3gram.st + ../streams/KY_3gram.st  + ../streams/JB_3gram.st  + ../streams/HJ_3gram.st + ../streams/L_notSR_3gram.st + ../streams/tdt4_3gram.st + ../streams/gigaword_3gram.st >& ../streams/intplt_notSR.LOG
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt_hasSR.weights + ../streams/SI_3gram.st + ../streams/PD_3gram.st + ../streams/KY_3gram.st  + ../streams/JB_3gram.st  + ../streams/HJ_3gram.st + ../streams/L_hasSR_3gram.st + ../streams/tdt4_3gram.st + ../streams/gigaword_3gram.st >& ../streams/intplt_hasSR.LOG

# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text
# -i 0.0886259236 ../lms/elder3gram_PD
# -i 0.0472488812 ../lms/elder3gram_KY
# -i 0.1107708207 ../lms/elder3gram_JB
# -i 0.0092653620 ../lms/elder3gram_HJ
# -i 0.5488634471 ../lms/elder3gram_L_hasSR
# -i 0.0213582132 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram
# -i 0.1247194087 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram
# ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG
#
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0783987817 ../lms/elder3gram_PD -i 0.0364961674 ../lms/elder3gram_KY -i 0.0976168964 ../lms/elder3gram_JB -i 0.0085570213 ../lms/elder3gram_HJ -i 0.5378398445 ../lms/elder3gram_L_hasSR -i 0.0184633325 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.1849658950 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge_hasSR >& ../lms/elder3gram_Merge_hasSR.LOG
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.1066724522 ../lms/elder3gram_PD -i 0.0511671312 ../lms/elder3gram_KY -i 0.1308649545 ../lms/elder3gram_JB -i 0.0123297550 ../lms/elder3gram_HJ -i 0.3718505288 ../lms/elder3gram_L_notSR -i 0.0192098333 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.2376853846 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge_notSR >& ../lms/elder3gram_Merge_notSR.LOG

# hasSR
#../streams/SI_3gram.st   0.0376620613
#../streams/PD_3gram.st   0.0783987817
#../streams/KY_3gram.st   0.0364961674
#../streams/JB_3gram.st   0.0976168964
#../streams/HJ_3gram.st   0.0085570213
#../streams/L_hasSR_3gram.st   0.5378398445
#../streams/tdt4_3gram.st   0.0184633325
#../streams/gigaword_3gram.st   0.1849658950
#
## notSR
#../streams/SI_3gram.st   0.0702199605
#../streams/PD_3gram.st   0.1066724522
#../streams/KY_3gram.st   0.0511671312
#../streams/JB_3gram.st   0.1308649545
#../streams/HJ_3gram.st   0.0123297550
#../streams/L_notSR_3gram.st   0.3718505288
#../streams/tdt4_3gram.st   0.0192098333
#../streams/gigaword_3gram.st   0.2376853846
#
ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_hasSR.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_notSR.ppl

ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR.gz -order 3 -ppl ../../corpora/version1/test_L_SR.txt > ../ppl/Merge_notSR_SR.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR.gz -order 3 -ppl ../../corpora/version1/test_L_SS.txt > ../ppl/Merge_notSR_SS.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR.gz -order 3 -ppl ../../corpora/version1/test_L_SI.txt > ../ppl/Merge_notSR_SI.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR.gz -order 3 -ppl ../../corpora/version1/test_L_PD.txt > ../ppl/Merge_notSR_PD.ppl


ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L_SR.txt > ../ppl/Merge_hasSR_SR.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L_SS.txt > ../ppl/Merge_hasSR_SS.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L_SI.txt > ../ppl/Merge_hasSR_SI.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR.gz -order 3 -ppl ../../corpora/version1/test_L_PD.txt > ../ppl/Merge_hasSR_PD.ppl


# 用测试集+开发集的词表对插值语言模型进行缩减
ngram -order 3 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist -limit-vocab -lm ../lms/elder3gram_Merge_hasSR.gz -write-lm ../lms/elder3gram_Merge_hasSR_prune.gz
ngram -order 3 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist -limit-vocab -lm ../lms/elder3gram_Merge_notSR.gz -write-lm ../lms/elder3gram_Merge_notSR_prune.gz

ngram -debug 2 -lm ../lms/elder3gram_Merge_hasSR_prune.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_hasSR_prune.ppl
ngram -debug 2 -lm ../lms/elder3gram_Merge_notSR_prune.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_notSR_prune.ppl
