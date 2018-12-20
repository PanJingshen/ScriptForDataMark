

# 三元
ngram-count -text ../corpora/train_SI.txt -order 3 -lm ../lms/elder3gram_SI.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_SI.LOG
ngram-count -text ../corpora/train_PD.txt -order 3 -lm ../lms/elder3gram_PD.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_PD.LOG
ngram-count -text ../corpora/train_OR.txt -order 3 -lm ../lms/elder3gram_OR.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_OR.LOG
ngram-count -text ../corpora/train_L.txt -order 3 -lm ../lms/elder3gram_L.gz -interpolate -kndiscount1 -kndiscount2 -kndiscount3 -debug 1 -gt2min 1 -gt3min 1 -gt4min 1 -vocab /mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.wlist >& ../lms/elder3gram_L.LOG


# test ppl

ngram -debug 2 -lm ../lms/elder3gram_SI.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/SI_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_PD.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/PD_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_OR.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/OR_3gram.ppl
ngram -debug 2 -lm ../lms/elder3gram_L.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/L_3gram.ppl

#ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/tdt4_3gram.ppl
#ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/gigaword_3gram.ppl
#ngram -debug 2 -lm /mnt/shareEx/srf/LM-Train/CLDC/lms_real/cldc-3gram.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/cldc_3gram.ppl



# 插值

# 1. 提取条件概率

cat ../ppl/SI_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/SI.st
cat ../ppl/PD_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/PD.st
cat ../ppl/OR_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/OR.st
cat ../ppl/L_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/L.st

#cat ../ppl/tdt4_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/tdt4.st
#cat ../ppl/gigaword_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/gigawrod.st
#cat ../ppl/cldc_3gram.ppl | egrep p'\(' | egrep -v '<unk' | awk '{printf("%e\n", $(NF-3));}' > ../streams/cldc.st


# 2. 计算权重
../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt.weights + ../streams/SI.st + ../streams/PD.st + ../streams/OR.st + ../streams/L.st >& ../streams/intplt.LOG
#../../scripts/interpolate -stop_ratio 0.999999 -max_probs 647940 -out_lambdas ../streams/intplt.weights + ../streams/SI.st + ../streams/PD.st + ../streams/OR.st + ../streams/L.st + ../streams/tdt4.st + ../streams/gigawrod.st + ../streams/cldc.st >& ../streams/intplt.LOG

# 3. 根据生成新模型
# Tips:语言模型后面不需要加‘.gz'
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0728750809 ../lms/elder3gram_PD -i 0.0041602776 ../lms/elder3gram_OR -i 0.8295280693 ../lms/elder3gram_L ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG
#LMerge -A -D -V -C ../../scripts/config.lnorm -T 1 -f text -i 0.0728750809 ../lms/elder3gram_PD -i 0.0041602776 ../lms/elder3gram_OR -i 0.8295280693 ../lms/elder3gram_L -i 0.8295280693 /mnt/shareEx/srf/LM-Train/TDT4/lms/tdt4-3gram -i 0.8295280693 /mnt/shareEx/srf/LM-Train/Gigaword/lms/gigaword-3gram -i 0.8295280693 /mnt/shareEx/srf/LM-Train/CLDC/lms_real/cldc-3gram ../../scripts/58k.chinese.ori.wlist ../lms/elder3gram_SI  ../lms/elder3gram_Merge >& ../lms/elder3gram_Merge.LOG


#ngram -debug 2 -lm ../lms/elder3gram_Merge.gz -order 3 -ppl ../corpora/test_L.txt > ../ppl/Merge.ppl