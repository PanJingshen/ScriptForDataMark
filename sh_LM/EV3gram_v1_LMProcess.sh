

# 三元
ngram-count -text ../corpora/train_SI.txt -order 3 -lm ../lms/elder3gram_SI.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_SI.LOG
ngram-count -text ../corpora/train_PD.txt -order 3 -lm ../lms/elder3gram_PD.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_PD.LOG
ngram-count -text ../corpora/train_OR.txt -order 3 -lm ../lms/elder3gram_OR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_OR.LOG

ngram-count -text ../corpora/train_KY.txt -order 3 -lm ../lms/elder3gram_KY.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_KY.LOG
ngram-count -text ../corpora/train_JB.txt -order 3 -lm ../lms/elder3gram_JB.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_JB.LOG
ngram-count -text ../corpora/train_HJ.txt -order 3 -lm ../lms/elder3gram_HJ.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_HJ.LOG


# test ppl

ngram -debug 2 -lm ../lms/elder3gram_SI.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/SI_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_PD.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/PD_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_OR.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/OR_3gram.ppl

ngram -debug 2 -lm ../lms/elder3gram_KY.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/KY_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_JB.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/JB_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_HJ.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/HJ_3gram.ppl

ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/tdt4_3gram.ppl
ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/gigaword_3gram.ppl
ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/CLDC/lms_real/cldc-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/cldc_3gram.ppl



# 插值

# 1. 提取条件概率

cat ../ppl/SI_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SI.st
cat ../ppl/PD_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PD.st
cat ../ppl/OR_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/OR.st

cat ../ppl/KY_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/KY.st
cat ../ppl/JB_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/JB.st
cat ../ppl/HJ_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/HJ.st

cat ../ppl/tdt4_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/tdt4.st
cat ../ppl/gigaword_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/gigawrod.st
cat ../ppl/cldc_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/cldc.st


# 2. 计算权重
#../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt.weights + ../streams/SI.st + ../streams/PD.st + ../streams/JB.st + ../streams/L.st >& ../streams/intplt.LOG
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt.weights + ../streams/SI.st + ../streams/PD.st + ../streams/OR.st + ../streams/KY.st + ../streams/JB.st + ../streams/HJ.st + ../streams/tdt4.st + ../streams/gigawrod.st + ../streams/cldc.st >& ../streams/intplt.LOG

# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0728750809 ../lms/elder3gram_PD -i 0.0041602776 ../lms/elder3gram_OR -i 0.8295280693 ../lms/elder3gram_L ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG


#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.2286008094 ../lms/elder3gram_PD -i 0.0100309683 ../lms/elder3gram_OR -i 0.0165410328 ../lms/elder3gram_KY -i 0.2377298675 ../lms/elder3gram_JB -i 0.0608041856 ../lms/elder3gram_HJ -i 0.0583918948 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.2248559078 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram -i 0.0000002048 /mnt/shareEx/srf/LM-Train/CLDC/lms_real/cldc-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG


../streams/SI.st   0.1630451288
../streams/PD.st   0.2286008094
../streams/OR.st   0.0100309683
../streams/KY.st   0.0165410328
../streams/JB.st   0.2377298675
../streams/HJ.st   0.0608041856
../streams/tdt4.st   0.0583918948
../streams/gigawrod.st   0.2248559078
../streams/cldc.st   0.0000002048


#../streams/SI.st   0.1630451288
#../streams/PD.st   0.2286008094
#../streams/OR.st   0.0100309683
#../streams/KY.st   0.0165410328
#../streams/JB.st   0.2377298675
#../streams/HJ.st   0.0608041856
#../streams/tdt4.st   0.0583918948
#../streams/gigawrod.st   0.2248559078
#../streams/cldc.st   0.0000002048

#ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/Merge.ppl