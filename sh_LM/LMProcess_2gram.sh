

# 三元
ngram-count -text ../../corpora/version1/train_SI.txt -order 2 -lm ../lms/elder2gram_SI.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_SI.LOG
ngram-count -text ../../corpora/version1/train_PD.txt -order 2 -lm ../lms/elder2gram_PD.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_PD.LOG

ngram-count -text ../../corpora/version1/train_KY.txt -order 2 -lm ../lms/elder2gram_KY.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_KY.LOG
ngram-count -text ../../corpora/version1/train_JB.txt -order 2 -lm ../lms/elder2gram_JB.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_JB.LOG
ngram-count -text ../../corpora/version1/train_HJ.txt -order 2 -lm ../lms/elder2gram_HJ.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_HJ.LOG

ngram-count -text ../../corpora/version1/train_L_hasSR.txt -order 2 -lm ../lms/elder2gram_L_hasSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_L_hasSR.LOG
ngram-count -text ../../corpora/version1/train_L_notSR.txt -order 2 -lm ../lms/elder2gram_L_notSR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder2gram_L_notSR.LOG


# test ppl

ngram -debug 2 -lm ../lms/elder2gram_SI.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/SI_2gram.ppl
ngram -debug 2 -lm ../lms/elder2gram_PD.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/PD_2gram.ppl

ngram -debug 2 -lm ../lms/elder2gram_KY.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/KY_2gram.ppl
ngram -debug 2 -lm ../lms/elder2gram_JB.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/JB_2gram.ppl
ngram -debug 2 -lm ../lms/elder2gram_HJ.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/HJ_2gram.ppl

ngram -debug 2 -lm ../lms/elder2gram_L_hasSR.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/L_hasSR_2gram.ppl
ngram -debug 2 -lm ../lms/elder2gram_L_notSR.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/L_notSR_2gram.ppl

ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-2gram.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/tdt4_2gram.ppl
ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-2gram.gz -order 3 -ppl ../../corpora/version1/test_L.txt > ../ppl/gigaword_2gram.ppl

# 插值

# 1. 提取条件概率

cat ../ppl/SI_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SI_2gram.st
cat ../ppl/PD_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PD_2gram.st

cat ../ppl/KY_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/KY_2gram.st
cat ../ppl/JB_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/JB_2gram.st
cat ../ppl/HJ_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/HJ_2gram.st

cat ../ppl/L_hasSR_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L_hasSR_2gram.st
cat ../ppl/L_notSR_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L_notSR_2gram.st

cat ../ppl/tdt4_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/tdt4_2gram.st
cat ../ppl/gigaword_2gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/gigaword_2gram.st



# 2. 计算权重
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt_notSR.weights + ../streams/SI_2gram.st + ../streams/PD_2gram.st + ../streams/KY_2gram.st  + ../streams/JB_2gram.st  + ../streams/HJ_2gram.st + ../streams/L_notSR_2gram.st + ../streams/tdt4_2gram.st + ../streams/gigaword_2gram.st >& ../streams/intplt_notSR.LOG
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt_hasSR.weights + ../streams/SI_2gram.st + ../streams/PD_2gram.st + ../streams/KY_2gram.st  + ../streams/JB_2gram.st  + ../streams/HJ_2gram.st + ../streams/L_hasSR_2gram.st + ../streams/tdt4_2gram.st + ../streams/gigaword_2gram.st >& ../streams/intplt_hasSR.LOG




# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text
# -i 0.0886259236 ../lms/elder2gram_PD
# -i 0.0472488812 ../lms/elder2gram_KY
# -i 0.1107708207 ../lms/elder2gram_JB
# -i 0.0092653620 ../lms/elder2gram_HJ
# -i 0.5488634471 ../lms/elder2gram_L_hasSR
# -i 0.0213582132 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-2gram
# -i 0.1247194087 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-2gram
# ../../scripts/58k.chinese.ori.wlist ../lms/elder2gram_SI  ../lms/elder2gram_Merge >& ../lms/elder2gram_Merge.LOG
#
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0885890733 ../lms/elder2gram_PD -i 0.0471855849 ../lms/elder2gram_KY -i 0.1103769957 ../lms/elder2gram_JB -i 0.0099264890 ../lms/elder2gram_HJ -i 0.5488098977 ../lms/elder2gram_L_hasSR -i 0.0221121643 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-2gram -i 0.1239516807 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-2gram ../../scripts/58k.chinese.ori.wlist ../lms/elder2gram_SI  ../lms/elder2gram_Merge_hasSR >& ../lms/elder2gram_Merge_hasSR.LOG
LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.1271666355 ../lms/elder2gram_PD -i 0.0691507645 ../lms/elder2gram_KY -i 0.1359167933 ../lms/elder2gram_JB -i 0.0163356293 ../lms/elder2gram_HJ -i 0.3902141450 ../lms/elder2gram_L_notSR -i 0.0257855364 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-2gram -i 0.1573045350 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-2gram ../../scripts/58k.chinese.ori.wlist ../lms/elder2gram_SI  ../lms/elder2gram_Merge_notSR >& ../lms/elder2gram_Merge_notSR.LOG

# hasSR
#../streams/SI_2gram.st   0.0490481144
#../streams/PD_2gram.st   0.0885890733
#../streams/KY_2gram.st   0.0471855849
#../streams/JB_2gram.st   0.1103769957
#../streams/HJ_2gram.st   0.0099264890
#../streams/L_hasSR_2gram.st   0.5488098977
#../streams/tdt4_2gram.st   0.0221121643
#../streams/gigaword_2gram.st   0.1239516807
#
## notSR
#../streams/SI_2gram.st   0.0781259610
#../streams/PD_2gram.st   0.1271666355
#../streams/KY_2gram.st   0.0691507645
#../streams/JB_2gram.st   0.1359167933
#../streams/HJ_2gram.st   0.0163356293
#../streams/L_notSR_2gram.st   0.3902141450
#../streams/tdt4_2gram.st   0.0257855364
#../streams/gigaword_2gram.st   0.1573045350
#
ngram -debug 2 -lm ../lms/elder2gram_Merge_hasSR.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_hasSR.ppl
ngram -debug 2 -lm ../lms/elder2gram_Merge_notSR.gz -order 2 -ppl ../../corpora/version1/test_L.txt > ../ppl/Merge_notSR.ppl