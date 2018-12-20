type=$1
MMF="MLBaseline/near/S2/hmm164/MMF"
DCT="../lib/dcts/58k.dct"
HMMList="MLBaseline/near/S2/xwrd.clustered.mlist"
alignMLF="../lib/wlabs/transcription_word.mlf"
alignSCP="/mnt/share/srf/FacialCapture/data/flists/near_plp_sg_${type}_new.scp"
outPutMLF="alignment/near/mlfs/near_align_${type}.mlf"
outPutLOG="alignment/near/logs/near_align_${type}.log"
jobs=20


#force alignment
mkdir temp20160808_${type}
cp $alignSCP temp20160808_${type}/align.scp
~/commen/scripts/splitFile.sh temp20160808_${type}/align.scp $jobs

for i in `seq 1 $jobs`
do
	HVite -f -o SW -A -D -i temp20160808_${type}/align_${i}.mlf -H $MMF -y lab -T 1 -C ../cfgs/hv-align.cfg -t 200.0 200.0 3000.1 -s 1.0 -a -m -I $alignMLF -b '<s>' -S temp20160808_${type}/align_sub${i}.scp $DCT $HMMList > temp20160808_${type}/align_${i}.LOG &
done
wait



echo '#!MLF!#' > $outPutMLF
cat temp20160808_${type}/align_*.mlf | grep -v '#!MLF!#' >> $outPutMLF
cat temp20160808_${type}/align_*.LOG > $outPutLOG

rm -r temp20160808_${type}

