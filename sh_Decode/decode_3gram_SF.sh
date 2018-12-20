#!/bin/sh   

# Update Log:
# LM 3gram

TAB="SF_v7_all"

ROOT="/mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram"

# output file
#outputFileHead="elder_decode"
#NEWTAB="${TAB}/${outputFileHead}"
NEWTAB="${TAB}"

# dirs
DIRRESULTTEMP="${ROOT}/results/${NEWTAB}"
DIRLOGTEMP="${ROOT}/logs/${NEWTAB}"
#DIRRESULT_ORI="${ROOT}/results/${outputFileHead}.mlf"
#DIRRESULT="${ROOT}/results/${outputFileHead}_results.mlf"
#DIRLOG="${ROOT}/results/${outputFileHead}.LOG"
#DIRLOGCOMP="${ROOT}/results/${outputFileHead}_cmp.LOG"

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

# HDecode input parameters
MMF="/mnt/shareEx/shizhuqing/LDC/work/S2_244_6000_hlda_3pitch_nospr/hmm244_hldamat/MMF"
HMMList="/mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist"
SCP="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/scp_sf/version2_all/Elder"
LM="/mnt/shareEx/panjingshen/ElderVoice/LM/EV3gram4SF_v1/lms/elder3gram_Merge_prune"
DCT="/mnt/shareEx/panjingshen/ElderVoice/LM/scripts/58k.chinese.ori.dct"



hdecodeBin="HDecode"
Config="cfgs/decode.cfg"

jobs=30
PruneBeamWidth1=250.0
PruneBeamWidth2=250.0
MaxModelPruning=3500  
WordendBeanWidth=125.0
LMScale=12.0
WordInsertionPenalty=0.0


/mnt/shareEx/shizhuqing/LDC/commen/scripts/splitFile.sh ${SCP}.scp $jobs


for i in `seq 1 $jobs`
do
    srun -p pBatch_all -w aimsl-123 HDecode -T 1 -A -D -V -C $Config -H $MMF -i ${DIRRESULTTEMP}/sub${i}.mlf -t $PruneBeamWidth1 $PruneBeamWidth2 -u $MaxModelPruning -v $WordendBeanWidth -s $LMScale -p $WordInsertionPenalty -n 24 -w $LM $DCT $HMMList -S ${SCP}_sub${i}.scp > ${DIRLOGTEMP}/sub${i}.log &
done

#wait
#rm -f ${SCP}_sub*.scp
