#!/bin/bash


mkdir -p temp_run_files
run_file_name=`date -d "today" +"%Y%m%d_%H%M%S"`
cat `echo $0` | grep -v "run_file_name=" | grep -v "temp_run_files" | grep -v "exit" > temp_run_files/${run_file_name}.sh
bash temp_run_files/${run_file_name}.sh
exit 0

nnet_config=cfgs/config-nnet-gale-basic
train_net_scheduler_config=cfgs/config-train-nnet-scheduler

learn_rate_perlayer=0.0003125
learn_rate_final=0.000625
 final_train_momentum=0.9
train_opts="--pre-eval false --max-iters 0 --max-iters-fix 1 --momentum 0.9"
# link_name="gale_mlp_6h_perlayer"
kaldi_hmm_model_dir=/mnt/shareEx/yanquanlei/OLD/work/kaldi_models_for_realign/hmm_alignModel_kaldi
train_align_pdf_ascii=/mnt/shareEx/yanquanlei/OLD/work/alignment/pdfs/ascii/train.pdf
train_lab_mlf=/mnt/share/yanquanlei/OLD/work/S2.mpe/lib/wlabs/all_words.mlf
 dev_lab_mlf=/mnt/share/yanquanlei/OLD/work/S2.mpe/lib/wlabs/all_words.mlf
# eval_lab_mlf=/mnt/shareEx/srf/SWBD/libs/wlabs/evalAll_kaldi.mlf
senone_map=/mnt/shareEx/yanquanlei/OLD/work/alignment/mappings/senone.map.new
senone_map_ids=/mnt/shareEx/yanquanlei/OLD/work/alignment/mappings/id_senone.map
 mono_list=/mnt/shareEx/yanquanlei/OLD/work/alignment/mappings/gale_chinese_mono.mlist



# load basic config, including train/test/dev scp etc.
source $nnet_config


log_dir=${log_dir}

output_root_dir=$log_dir
mkdir -p $log_dir/cfgs
mkdir -p $output_root_dir

cp $nnet_config $log_dir/cfgs/
cp $train_net_scheduler_config $log_dir/cfgs/


# print all configs into 'config.log'
echo "#basic nnet_config config:" > $log_dir/config.log
echo ""  >> $log_dir/config.log
cat $nnet_config >> $log_dir/config.log
echo ""  >> $log_dir/config.log
echo ""  >> $log_dir/config.log
echo "************************************************************"  >> $log_dir/config.log
echo ""  >> $log_dir/config.log
echo ""  >> $log_dir/config.log
echo "#train_net_scheduler_config config:"  >> $log_dir/config.log
echo ""  >> $log_dir/config.log
cat $train_net_scheduler_config >> $log_dir/config.log
echo ""  >> $log_dir/config.log
echo ""  >> $log_dir/config.log



train_opts_cfg=$output_root_dir/train_opts_cfg
echo "train_opts=\"${train_opts}\"" > $train_opts_cfg


# ln -s /mnt/shareEx/srf/Gale/work/DNN_audio/$link_name/dpt_perlayer1 $output_root_dir/dpt_perlayer1
# ln -s /mnt/shareEx/srf/Gale/work/DNN_audio/$link_name/dpt_perlayer6 $output_root_dir/dpt_perlayer6



# 逐层训练
   # mlp_dir=$output_root_dir/dpt_perlayer1
    # mlp_trans=$mlp_dir/final.feature_transform
# mkdir -p $mlp_dir

# ~/DBN_DNN_tools/utils/bash/nnet_init.sh \
  # --hid-layers 1 \
  # --hid-dim 2048 \
   # --delta_opts "--delta-order=3" \
  # $mlp_dir $train_scp $dev_scp $train_label $dev_label $label_num > $output_root_dir/mlp_perlayer1.log 2>&1


# bash ~/DBN_DNN_tools/utils/bash/mlp_train_label.sh \
 # --nnet-init $mlp_dir/nnet.init \
 # --learn-rate $learn_rate_perlayer \
 # --config $train_opts_cfg \
 # --feature-transform $mlp_trans \
 # $mlp_dir $train_scp $dev_scp $train_label $dev_label $label_num  $train_net_scheduler_config >> $output_root_dir/mlp_perlayer1.log 2>&1



# for i in `seq 2 6`; do

	# mlp_before_dir=$mlp_dir
	# mlp_dir=$output_root_dir/dpt_perlayer${i}
	# mkdir -p $mlp_dir

	# ~/DBN_DNN_tools/utils/bash/nnet_init_simple.sh \
	  # --hid-layers 1 \
	  # --hid-dim 2048 \
	  # --delta_opts "--delta-order=3" \
	  # $mlp_dir 2048 $label_num > $output_root_dir/mlp_perlayer${i}.log 2>&1

	# nnet-copy --remove-last-components=2 $mlp_before_dir/final.nnet - | \
	  # nnet-concat $mlp_before_dir/final.feature_transform - $mlp_dir/final.feature_transform


	# bash ~/DBN_DNN_tools/utils/bash/mlp_train_label.sh \
	  # --nnet-init $mlp_dir/nnet.init \
	  # --learn-rate $learn_rate_perlayer \
	  # --config $train_opts_cfg \
	  # --feature-transform $mlp_dir/final.feature_transform \
	  # --delta_opts "--delta-order=3" \
	  # $mlp_dir $train_scp $dev_scp $train_label $dev_label $label_num  $train_net_scheduler_config >> $output_root_dir/mlp_perlayer${i}.log 2>&1

# done



# 最后大训练
# mlp_before_dir=$output_root_dir/dpt_perlayer6
  mlp_dir=$output_root_dir/dpt_perlayer_final
# mkdir -p $mlp_dir

# nnet-concat "nnet-copy --remove-first-components=3 $mlp_before_dir/final.feature_transform -|" $mlp_before_dir/final.nnet $mlp_dir/nnet.init

# bash ~/DBN_DNN_tools/utils/bash/mlp_train_label.sh \
  # --nnet-init $mlp_dir/nnet.init \
  # --learn-rate $learn_rate_final \
  # --momentum $final_train_momentum \
  # --max-iters 0 \
  # --max-iters-fix 5 \
  # --max-iters-dec 40 \
  # --feature-transform $mlp_trans \
  # $mlp_dir $train_scp $dev_scp $train_label $dev_label $label_num  $train_net_scheduler_config >> $output_root_dir/mlp_perlayer_final.log 2>&1



   # nnet-train-frmshuff --cross-validate=true --objective-function=xent --use-gpu=yes --minibatch-size=128 --randomizer-size=131072 --randomize=false --verbose=1 --feature-transform=$mlp_dir/final.feature_transform "ark:copy-feats scp:${test_scp} ark:- |" scp:/mnt/shareEx/yanquanlei/OLD/work/alignment/pdfs/gale_all.post.scp $mlp_dir/final.nnet >& $output_root_dir/test_frame_accuracy.log


# 强制对齐
 # bash /mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/realign.sh \
   # --nouniq-alignText false \
   # $mlp_dir $kaldi_hmm_model_dir $train_align_pdf_ascii $train_lab_mlf $train_scp train_realign
 # bash /mnt/shareEx/yanquanlei/DBN_DNN_tools/scripts/realign.sh \
   # --nouniq-alignText false \
   # $mlp_dir $kaldi_hmm_model_dir $train_align_pdf_ascii $dev_lab_mlf $dev_scp dev_realign


# 专门针对测试集进行强制对齐
# bash ~/DBN_DNN_tools/scripts/realign.sh \
  # --nouniq-alignText false \
  # $mlp_dir $kaldi_hmm_model_dir $train_align_pdf_ascii $eval_lab_mlf $test_scp test_realign

# bash ~/DBN_DNN_tools/scripts/realign_senone2mono.sh $mlp_dir $senone_map $senone_map_ids $mono_list


# 解码
 # bash scripts/hybridDecode.sh $mlp_dir $output_root_dir $old_test_scp
# mv $output_root_dir/hybrid $output_root_dir/hybrid_old_test
 # bash scripts/hybridDecode.sh $mlp_dir $output_root_dir $old_mci_scp
# mv $output_root_dir/hybrid $output_root_dir/hybrid_old_mci
 # bash scripts/hybridDecode.sh $mlp_dir $output_root_dir $old_ad_scp
# mv $output_root_dir/hybrid $output_root_dir/hybrid_old_ad
 bash scripts/hybridDecode.sh $mlp_dir $output_root_dir $sf_scp
mv $output_root_dir/hybrid $output_root_dir/hybrid_old_sf


# 汇总
# hmmList="/mnt/shareEx/srf/SWBD/work/ML_baseline/pitch.hlda.28mix/xwrd.clustered.mlist"
# standardMLF="/mnt/shareEx/srf/SWBD/libs/wlabs/evalAll_standard.mlf"
# mkdir -p $output_root_dir/hybrid_evalAll/decode
# cat $output_root_dir/hybrid_eval03/decode/hybrid_eval.mlf $output_root_dir/hybrid_eval97/decode/hybrid_eval.mlf > $output_root_dir/hybrid_evalAll/decode/hybrid_eval.mlf
# HResults -h -I $standardMLF $hmmList $output_root_dir/hybrid_evalAll/decode/hybrid_eval.mlf > $output_root_dir/hybrid_evalAll/decode/cmp_eval_CER


