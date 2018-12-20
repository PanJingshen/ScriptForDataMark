neuralNetworkPath=$1
outPutRoot=$2
testSCP=$3

job_num=30
num_threads_per_job=4
acoustic_wei=0.083333
LM_scale=12.0
WI_penalty=10.0
beam=13.0 # beam for decoding.  Was 13.0 in the scripts.
latbeam=10.0 # this has most effect on size of the lattices.
max_active=10500
# max_active=3500
use_gpu=yes


hybridConversionPath="/mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/hybrid/conversion"
hybridScriptPath="/mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/hybrid/decodeScripts"
fstBin="/home/aimsl/tools/kaldi-trunk/tools/openfst-1.3.4/bin"


graph_dir="/mnt/shareEx/yanquanlei/OLD/work/kaldi_models_for_decoding_uni/hmm_decodeModel"
hmmList="/mnt/shareEx/yanquanlei/OLD/libs/mlists/xwrd.clustered.mlist"
standardMLF="/mnt/shareEx/yanquanlei/OLD/libs/mlfs/stardard_ad.mlf"
trainAlignPDFs="/mnt/shareEx/yanquanlei/OLD/work/alignment/pdfs/ascii/train.pdf"
outPutPath=$outPutRoot/hybrid

neuralNetworkPath=`/mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/get_absolute_path.sh $neuralNetworkPath`
outPutPath=`/mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/get_absolute_path.sh $outPutPath`

#�����Ŀ¼��  
mkdir -p $outPutPath
analyze-counts --binary=false ark:$trainAlignPDFs $outPutPath/ali_pdf_train.counts
copy-transition-model --binary=false $graph_dir/final.mdl $outPutPath/final.mdl
ln -s $graph_dir/tree $outPutPath/tree
ln -s $neuralNetworkPath/final.nnet $outPutPath/final.nnet
ln -s $neuralNetworkPath/final.feature_transform $outPutPath/final.feature_transform
ln -s $neuralNetworkPath/delta_order $outPutPath/delta_order

 cp $testSCP $outPutPath/feats.scp


# ������ѹ��(�õ�lattice��,�������lattice-lmrescore,����lattice-scale��lattice-add-penalty,���lattice-best-path)
# ���߳�ʹ��С������ģ�ͽ���,����lattice
bash $hybridScriptPath/decode_hybrid.sh --nj $job_num --acwt $acoustic_wei --num-threads $num_threads_per_job --max-active $max_active --beam $beam --latbeam $latbeam --use-gpu $use_gpu   \
  $graph_dir $outPutPath $outPutPath/lattices >& $outPutPath/hybrid.log
  

# ���߳�ʹ��ԭ�е�����ģ����������lattice
mkdir -p $outPutPath/decode
for i in `seq $job_num`; do
	lattice-lmrescore --lm-scale=-1.0 ark:$outPutPath/lattices/lat.${i} "$fstBin/fstproject --project_output=true $graph_dir/G.fst |" ark:- | lattice-lmrescore --lm-scale=1.0 ark:- "$fstBin/fstproject --project_output=true $graph_dir/G_noprune.fst |" ark,t:$outPutPath/lattices/${i}_truelm.lat &
done
wait
cat $outPutPath/lattices/*_truelm.lat > $outPutPath/decode/all.lat

# ����·��,�ó�������
# �ý�����ʹ��id��ʾ,�����Ҫ��ߵ�mapping����
lattice-best-path --acoustic-scale=$acoustic_wei ark:$outPutPath/decode/all.lat ark,t:$outPutPath/decode/eval.tra ark,t:$outPutPath/decode/eval.ali 2> $outPutPath/decode/rescore.log
rm $outPutPath/decode/all.lat

# mapping����,�ó������Ľ�����,������hybrid_eval.mlf��
perl $hybridScriptPath/id2work.pl $outPutPath/decode/eval.tra $graph_dir/words.txt > $outPutPath/decode/eval_trans.txt
perl $hybridScriptPath/get_mlf.pl $outPutPath/decode/eval_trans.txt > $outPutPath/decode/hybrid_eval.mlf

# HResults,�õ�CER
 HResults -h -I $standardMLF $hmmList $outPutPath/decode/hybrid_eval.mlf > $outPutPath/decode/cmp_eval_CER


 rm -r $outPutPath/lattices
