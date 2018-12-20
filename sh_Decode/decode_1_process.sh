#!/bin/sh


### 版本号
TAB="temp_v5"
####


ROOT="/mnt/shareEx/panjingshen/ElderVoice/WORK/version1"

# output file
outputFileHead="elder_decode"
#NEWTAB="${TAB}/${outputFileHead}"
NEWTAB="${TAB}"

# dirs
DIRRESULTTEMP="${ROOT}/results/${NEWTAB}"
DIRLOGTEMP="${ROOT}/logs/${NEWTAB}"
DIRRESULT_ORI="${ROOT}/results/${NEWTAB}/${outputFileHead}.mlf"
DIRRESULT="${ROOT}/results/${NEWTAB}/${outputFileHead}_results.mlf"
DIRLOG="${ROOT}/results/${NEWTAB}/${outputFileHead}.LOG"
DIRLOGCOMP="${ROOT}/results/${NEWTAB}/${outputFileHead}_cmp.LOG"

if [ -d ${DIRRESULTTEMP} ] ; then
echo ""
else
mkdir -p ${DIRRESULTTEMP}
fi

if [ -d ${DIRLOGTEMP} ] ; then
echo ""
else
mkdir -p ${DIRLOGTEMP}
fi

# hdecode input parameters

MMF="/mnt/shareEx/shizhuqing/LDC/work/S2_244_6000_hlda_3pitch_nospr/hmm244_hldamat/MMF"
HMMList="/mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist"
# 可变
SCP="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/scp_v3_test/sub20_21/Elder"
#SCP="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/scp_1/Elder"
# 语言模型
LM="/mnt/shareEx/xxr/gale/interpolate-gigaword-gale-prune9"
# 字典
DCT="/mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.dct"
hdecodeBin="HDecode"
standardMLF="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_v3.mlf"
# 配置文件
Config="cfgs/decode.cfg"

jobs=4
PruneBeamWidth1=250.0
PruneBeamWidth2=250.0
MaxModelPruning=3500
WordendBeanWidth=125.0
LMScale=12.0
WordInsertionPenalty=0.0

# command

cat ${DIRRESULTTEMP}/sub*.mlf > ${DIRRESULT_ORI}
cat ${DIRLOGTEMP}/sub*.log > ${DIRLOG}


#delete the temp file
#rm -r ${ROOT}/results/${TAB}
#rm -r ${ROOT}/results/logs


# get results

/mnt/share/yanquanlei/commen/scripts/combine.pl ${DIRRESULT_ORI} > ${DIRRESULT}
#HResults -e "???" sil -e "???" sp -h -A -D -T 1 -I $standardMLF $HMMList ${DIRRESULT} > ${DIRLOGCOMP}

