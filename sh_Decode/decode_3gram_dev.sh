#!/bin/sh   



###
TAB="dev_v2"
####


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

# hdecode input parameters

MMF="/mnt/shareEx/shizhuqing/LDC/work/S2_244_6000_hlda_3pitch_nospr/hmm244_hldamat/MMF"
HMMList="/mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist"
#可变
SCP="/mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/scp_dev/version3/Elder"
LM="/mnt/shareEx/panjingshen/ElderVoice/LM/EV3gram_v2/lms/elder3gram_Merge_notSR_prune"
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


#/mnt/shareEx/shizhuqing/LDC/commen/scripts/splitFile.sh ${SCP}.scp $jobs

for i in `seq 1 $jobs`
do
#     $hdecodeBin -T 1 -A -D -V -C $Config -H $MMF -i ${DIRRESULTTEMP}/sub${i}.mlf -t $PruneBeamWidth1 $PruneBeamWidth2 -u $MaxModelPruning -v $WordendBeanWidth -s $LMScale -p $WordInsertionPenalty -n 24 -w $LM $DCT $HMMList -S ${SCP}_sub${i}.scp > ${DIRLOGTEMP}/sub${i}.log &
    srun -p pBatch_all -w aimsl-123 HDecode -T 1 -A -D -V -C $Config -H $MMF -i ${DIRRESULTTEMP}/sub${i}.mlf -t $PruneBeamWidth1 $PruneBeamWidth2 -u $MaxModelPruning -v $WordendBeanWidth -s $LMScale -p $WordInsertionPenalty -n 24 -w $LM $DCT $HMMList -S ${SCP}_sub${i}.scp > ${DIRLOGTEMP}/sub${i}.log &
#    sleep 5
done



#wait
#rm -f ${SCP}_sub*.scp
# echo " combining ....."

# cat ${DIRRESULTTEMP}/sub*.mlf > ${DIRRESULT_ORI}
# cat ${DIRLOGTEMP}/sub*.log > ${DIRLOG}


#delete the temp file
#rm -r ${ROOT}/results/${TAB}
#rm -r ${ROOT}/results/logs


# get results

# /mnt/share/yanquanlei/commen/scripts/combine.pl ${DIRRESULT_ORI} > ${DIRRESULT}
#HResults -e "???" sil -e "???" sp -h -A -D -T 1 -I $standardMLF $HMMList ${DIRRESULT} > ${DIRLOGCOMP}




# 对CCTV,NTDTV和PHOENIX单独分析
#result_details=${ROOT}/results/details
#mkdir -p $result_details

#show_name="CCTV"
#show_list="/mnt/share/srf/Gale/lib/flists/${show_name}_show_utt.list"
#echo "#!MLF!#" > $result_details/${show_name}_cmp_result.mlf
#for id_name in `cat $show_list`;do
	# echo $id_name
#	perl ~/commen/scripts/extractLabsFromMLF.pl ${DIRRESULT} $id_name >> $result_details/${show_name}_cmp_result.mlf
#done


	

	
