#!/bin/sh


###
TAB="mci_v2"
####


ROOT="/mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram"

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
#可变
standardMLF="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf"
Config="cfgs/decode.cfg"



# command

cat ${DIRRESULTTEMP}/sub*.mlf > ${DIRRESULT_ORI}
cat ${DIRLOGTEMP}/sub*.log > ${DIRLOG}


#delete the temp file
#rm -r ${ROOT}/results/${TAB}
#rm -r ${ROOT}/results/logs


# get results

/mnt/share/yanquanlei/commen/scripts/combine.pl ${DIRRESULT_ORI} > ${DIRRESULT}
HResults -e "???" sil -e "???" sp -h -A -D -T 1 -I $standardMLF $HMMList ${DIRRESULT} > ${DIRLOGCOMP}

#
#HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/elder_decode_results.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/elder_decode_cmp.LOG
#

HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_results_SI.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_SI_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_results_SS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_SS_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v4/decode_SIandSS_cmp.LOG


HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_results_SI.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_SI_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_results_SS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/EV_3gram/results/mci_v2/dnn/decode_SS_cmp.LOG



HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2_SAT/decode_SIandSS_cmp.LOG
#
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/DNN/mci/version2/decode_SIandSS_cmp.LOG
#