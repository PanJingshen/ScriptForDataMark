neuralNetworkPath=$1
outPutRoot=$2
testSCP=$3

job_num=100
num_threads_per_job=1
acoustic_wei=0.083333
LM_scale=12.0
WI_penalty=10.0
beam=13.0 # beam for decoding.  Was 13.0 in the scripts.
latbeam=10.0 # this has most effect on size of the lattices.
max_active=10500
# max_active=3500
use_gpu=no


hybridConversionPath="/mnt/shareEx/srf/DBN_DNN_tools/scripts/hybrid/conversion"
hybridScriptPath="/mnt/shareEx/srf/DBN_DNN_tools/scripts/hybrid/decodeScripts"
fstBin="/mnt/shareEx/yangjingzhou/kaldi/kaldi-master/tools/openfst-1.6.5/bin"
srun_bin="srun -p pBatch_level4"


graph_dir="/mnt/shareEx/srf/Gale/work_500h/kaldi_fst/decode_model"
hmmList="/mnt/shareEx/srf/Gale/work_500h/ML_baseline/S2.kaldipitch.hlda/xwrd.clustered.mlist"
standardMLF="/mnt/shareEx/srf/Gale/lib/wlabs/recent/both_word_lab_kaldi.mlf"
trainAlignPDFs="/mnt/shareEx/srf/Gale/work_500h/ML_baseline/alignment/pdfs/ascii/ali_train.pdf"
outPutPath=$outPutRoot/hybrid

neuralNetworkPath=`~/DBN_DNN_tools/scripts/get_absolute_path.sh $neuralNetworkPath`
outPutPath=`~/DBN_DNN_tools/scripts/get_absolute_path.sh $outPutPath`

#�����Ŀ¼��  
mkdir -p $outPutPath
analyze-counts --binary=false ark:$trainAlignPDFs $outPutPath/ali_pdf_train.counts
copy-transition-model --binary=false $graph_dir/final.mdl $outPutPath/final.mdl
ln -s $graph_dir/tree $outPutPath/tree
ln -s $neuralNetworkPath/final.nnet $outPutPath/final.nnet
ln -s $neuralNetworkPath/final.feature_transform $outPutPath/final.feature_transform


cp $testSCP $outPutPath/feats.scp


# ������ѹ��(�õ�lattice��,�������lattice-lmrescore,����lattice-scale��lattice-add-penalty,���lattice-best-path)
# ���߳�ʹ��С������ģ�ͽ���,����lattice
bash $hybridScriptPath/decode_hybrid.sh --srun-bin $srun_bin --nj $job_num --acwt $acoustic_wei --num-threads $num_threads_per_job --max-active $max_active --beam $beam --latbeam $latbeam --use-gpu $use_gpu \
  $graph_dir $outPutPath $outPutPath/lattices >& $outPutPath/hybrid.log
  

# ���߳�ʹ��ԭ�е�����ģ����������lattice
mkdir -p $outPutPath/decode
for i in `seq $job_num`; do
	$srun_bin lattice-lmrescore --lm-scale=-1.0 ark:$outPutPath/lattices/lat.${i} "$fstBin/fstproject --project_output=true $graph_dir/G.fst |" ark:- | lattice-lmrescore --lm-scale=1.0 ark:- "$fstBin/fstproject --project_output=true $graph_dir/G_noprune.fst |" ark,t:$outPutPath/lattices/${i}_truelm.lat &
	sleep 0.5
done
wait
# cat $outPutPath/lattices/*_truelm.lat > $outPutPath/decode/all.lat

# ����·��,�ó�������
# �ý�����ʹ��id��ʾ,�����Ҫ��ߵ�mapping����
lattice-best-path --acoustic-scale=$acoustic_wei ark:$outPutPath/lattices/*_truelm.lat ark,t:$outPutPath/decode/eval.tra ark,t:$outPutPath/decode/eval.ali 2> $outPutPath/decode/rescore.log
rm $outPutPath/decode/all.lat

# mapping����,�ó������Ľ�����,������hybrid_eval.mlf��
perl $hybridScriptPath/id2work.pl $outPutPath/decode/eval.tra $graph_dir/words.txt > $outPutPath/decode/eval_trans.txt
perl $hybridScriptPath/get_mlf.pl $outPutPath/decode/eval_trans.txt > $outPutPath/decode/hybrid_eval.mlf


# HResults,�õ�CER
HResults -h -I $standardMLF $hmmList $outPutPath/decode/hybrid_eval.mlf > $outPutPath/decode/cmp_eval_CER


rm -r $outPutPath/lattices

# ��CCTV,NTDTV��PHOENIX��������
result_details=$outPutPath/decode/details
mkdir -p $result_details

show_name="CCTV"
show_list="/mnt/shareEx/srf/Gale/lib/flists/${show_name}_show_utt.list"
echo "#!MLF!#" > $result_details/${show_name}_cmp_hybrid_result.mlf
for id_name in `cat $show_list`;do
	# echo $id_name
	perl ~/commen/scripts/extractLabsFromMLF.pl $outPutPath/decode/hybrid_eval.mlf $id_name >> $result_details/${show_name}_cmp_hybrid_result.mlf
done

HResults -e "???" sil -e "???" sp -h -I $standardMLF $hmmList $result_details/${show_name}_cmp_hybrid_result.mlf > $result_details/${show_name}_cmp_eval_CER
	
show_name="NTDTV"
show_list="/mnt/shareEx/srf/Gale/lib/flists/${show_name}_show_utt.list"
echo "#!MLF!#" > $result_details/${show_name}_cmp_hybrid_result.mlf
for id_name in `cat $show_list`;do
	# echo $id_name
	perl ~/commen/scripts/extractLabsFromMLF.pl $outPutPath/decode/hybrid_eval.mlf $id_name >> $result_details/${show_name}_cmp_hybrid_result.mlf
done

HResults -e "???" sil -e "???" sp -h -I $standardMLF $hmmList $result_details/${show_name}_cmp_hybrid_result.mlf > $result_details/${show_name}_cmp_eval_CER
	
	

show_name="PHOENIX"
show_list="/mnt/shareEx/srf/Gale/lib/flists/${show_name}_show_utt.list"
echo "#!MLF!#" > $result_details/${show_name}_cmp_hybrid_result.mlf
for id_name in `cat $show_list`;do
	# echo $id_name
	perl ~/commen/scripts/extractLabsFromMLF.pl $outPutPath/decode/hybrid_eval.mlf $id_name >> $result_details/${show_name}_cmp_hybrid_result.mlf
done

HResults -e "???" sil -e "???" sp -h -I $standardMLF $hmmList $result_details/${show_name}_cmp_hybrid_result.mlf > $result_details/${show_name}_cmp_eval_CER
	
	

	