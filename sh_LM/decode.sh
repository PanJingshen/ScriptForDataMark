#!/bin/sh   



###
TAB="temp20180816"
####


ROOT="/mnt/share/yanquanlei/OLD/work/S4"

# output file
outputFileHead="old_decode_4"
NEWTAB="${TAB}/${outputFileHead}"

# dirs
DIRRESULTTEMP="${ROOT}/results/${NEWTAB}"
DIRLOGTEMP="${ROOT}/results/logs/${NEWTAB}"
DIRRESULT_ORI="${ROOT}/results/${outputFileHead}.mlf"
DIRRESULT="${ROOT}/results/${outputFileHead}_results.mlf"
DIRLOG="${ROOT}/results/${outputFileHead}.LOG"
DIRLOGCOMP="${ROOT}/results/${outputFileHead}_cmp.LOG"

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

MMF="/mnt/shareEx/nihu/jg/S2_244_6000_hlda_3pitch_nospr_adapttrain/hmm244a_global_para_04/MMF"
HMMList="/mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist"
#可变
SCP="/mnt/share/yanquanlei/OLD/work/S4/scp/feats"
# SCP="flists/near_plp_sg_test"
LM="/mnt/shareEx/xxr/gale/interpolate-gigaword-gale-prune9"
DCT="/mnt/shareEx/srf/Gale/lib/dcts/58k.dct.orig.new"
hdecodeBin="HDecode"
#standardMLF="/mnt/shareEx/srf/Gale/lib/wlabs/both_word_lab_kaldi.mlf"
Config="cfgs/decode.cfg"

jobs=60
PruneBeamWidth1=250.0
PruneBeamWidth2=250.0
MaxModelPruning=3500  
WordendBeanWidth=125.0
LMScale=12.0
WordInsertionPenalty=0.0

/mnt/shareEx/shizhuqing/LDC/commen/scripts/splitFile.sh ${SCP}.scp $jobs

# for i in `seq 1 $jobs`
# do
	# $hdecodeBin -T 1 -A -D -V -C $Config -H $MMF -i ${DIRRESULTTEMP}/sub${i}.mlf -t $PruneBeamWidth1 $PruneBeamWidth2 -u $MaxModelPruning -v $WordendBeanWidth -s $LMScale -p $WordInsertionPenalty -n 24 -w $LM $DCT $HMMList -S ${SCP}_sub${i}.scp > ${DIRLOGTEMP}/sub${i}.log &
# done
#wait
#rm -f ${SCP}_sub*.scp
echo " combining ....."

cat ${DIRRESULTTEMP}/sub*.mlf > ${DIRRESULT_ORI}
cat ${DIRLOGTEMP}/sub*.log > ${DIRLOG}


#delete the temp file
#rm -r ${ROOT}/results/${TAB}
#rm -r ${ROOT}/results/logs


# get results

#~/commen/scripts/combine.pl ${DIRRESULT_ORI} > ${DIRRESULT}
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


	

	
