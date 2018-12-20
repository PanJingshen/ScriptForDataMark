MMF="MLBaseline/near/S2/hmm164/MMF"

# alignment/near/: get pdfs from ML baseline
mkdir -p alignment/near/

mkdir -p alignment/near/pdfs/ascii
mkdir -p alignment/near/mlfs
mkdir -p alignment/near/mappings
mkdir -p alignment/near/logs

# do alignment/near/
bash scripts/near_FA.sh dev
bash scripts/near_FA.sh train
bash scripts/near_FA.sh test


cat alignment/near/pdfs/ascii/near_ali_train.pdf alignment/near/pdfs/ascii/near_ali_dev.pdf > alignment/near/pdfs/ascii/near_ali_train_dev.pdf

# HVite -f -o SW -A -D -i alignment/near/mlfs/near_align_dev.mlf -H S2/hmm164/MMF -y lab -T 1 -C ../cfgs/hv-align.cfg -t 200.0 200.0 3000.1 -s 1.0 -a -m -I ../lib/wlabs/transcription_word_dev.mlf -b '<s>' -S ../lib/flists/near_plp_sg_dev.scp ../lib/dcts/58k.dct S2/xwrd.clustered.mlist > alignment/near/logs/near_align_dev.log &


# HVite -f -o SW -A -D -i alignment/near/mlfs/near_align_train.mlf -H S2/hmm164/MMF -y lab -T 1 -C ../cfgs/hv-align.cfg -t 200.0 200.0 3000.1 -s 1.0 -a -m -I ../lib/wlabs/transcription_word_train.mlf -b '<s>' -S ../lib/flists/near_plp_sg_train.scp ../lib/dcts/58k.dct S2/xwrd.clustered.mlist > alignment/near/logs/near_align_train.log &


# create acii alignment/near/ pdf
# for triphone
perl /mnt/share/srf/DBN_DNN_tools/scripts/senone_map.pl $MMF alignment/near/mappings/senoneF alignment/near/mappings/triphoneF > alignment/near/mappings/senone.map
perl /mnt/share/srf/DBN_DNN_tools/scripts/senone_mlf.pl alignment/near/mlfs/near_align_dev.mlf alignment/near/mappings/senone.map 100000 alignment/near/mappings/senoneF alignment/near/mappings/id_senone.map | perl scripts/replace.pl -  > alignment/near/pdfs/ascii/near_ali_dev.pdf
perl /mnt/share/srf/DBN_DNN_tools/scripts/senone_mlf.pl alignment/near/mlfs/near_align_train.mlf alignment/near/mappings/senone.map 100000 alignment/near/mappings/senoneF alignment/near/mappings/id_senone.map | perl scripts/replace.pl - > alignment/near/pdfs/ascii/near_ali_train.pdf
perl /mnt/share/srf/DBN_DNN_tools/scripts/senone_mlf.pl alignment/near/mlfs/near_align_test.mlf alignment/near/mappings/senone.map 100000 alignment/near/mappings/senoneF alignment/near/mappings/id_senone.map | perl scripts/replace.pl - > alignment/near/pdfs/ascii/near_ali_test.pdf

# for mono
perl /mnt/share/srf/DBN_DNN_tools/scripts/mono_mlf.pl alignment/near/mlfs/near_align_dev.mlf 100000 /mnt/share/srf/FacialCapture/lib/mlists/mono.mlist alignment/near/mappings/id_mono.map | perl scripts/replace.pl - > alignment/near/pdfs/ascii/near_mono_ali_dev.pdf
perl /mnt/share/srf/DBN_DNN_tools/scripts/mono_mlf.pl alignment/near/mlfs/near_align_train.mlf 100000 /mnt/share/srf/FacialCapture/lib/mlists/mono.mlist alignment/near/mappings/id_mono.map | perl scripts/replace.pl - > alignment/near/pdfs/ascii/near_mono_ali_train.pdf
perl /mnt/share/srf/DBN_DNN_tools/scripts/mono_mlf.pl alignment/near/mlfs/near_align_test.mlf 100000 /mnt/share/srf/FacialCapture/lib/mlists/mono.mlist alignment/near/mappings/id_mono.map | perl scripts/replace.pl - > alignment/near/pdfs/ascii/near_mono_ali_test.pdf


# change the format
ali-to-post ark:alignment/near/pdfs/ascii/near_ali_dev.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_ali_dev.post,alignment/near/pdfs/near_ali_dev.post.scp
ali-to-post ark:alignment/near/pdfs/ascii/near_ali_train.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_ali_train.post,alignment/near/pdfs/near_ali_train.post.scp
ali-to-post ark:alignment/near/pdfs/ascii/near_ali_test.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_ali_test.post,alignment/near/pdfs/near_ali_test.post.scp
ali-to-post ark:alignment/near/pdfs/ascii/near_mono_ali_dev.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_mono_ali_dev.post,alignment/near/pdfs/near_mono_ali_dev.post.scp
ali-to-post ark:alignment/near/pdfs/ascii/near_mono_ali_train.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_mono_ali_train.post,alignment/near/pdfs/near_mono_ali_train.post.scp
ali-to-post ark:alignment/near/pdfs/ascii/near_mono_ali_test.pdf ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_mono_ali_test.post,alignment/near/pdfs/near_mono_ali_test.post.scp

cat alignment/near/pdfs/near_mono_ali_train.post.scp alignment/near/pdfs/near_mono_ali_test.post.scp alignment/near/pdfs/near_mono_ali_dev.post.scp > alignment/near/pdfs/near_mono_ali_all.post.scp
cat alignment/near/pdfs/near_ali_train.post.scp alignment/near/pdfs/near_ali_dev.post.scp alignment/near/pdfs/near_ali_test.post.scp > alignment/near/pdfs/near_ali_all.post.scp

# get the utts length infomation
perl scripts/getUttLengthInfo.pl alignment/near/pdfs/ascii/near_ali_dev.pdf | sort - > alignment/near/pdfs/near_ali_dev.uttLen
perl scripts/getUttLengthInfo.pl alignment/near/pdfs/ascii/near_ali_train.pdf | sort - > alignment/near/pdfs/near_ali_train.uttLen
perl scripts/getUttLengthInfo.pl alignment/near/pdfs/ascii/near_ali_test.pdf | sort - > alignment/near/pdfs/near_ali_test.uttLen


# check this length infomation
# if no error occur, do next
feat-to-len scp:/mnt/share/srf/FacialCapture/data/fbank_data_24d_seperated/near_fbank_dev_new.scp ark,t:- | sort - > alignment/near/pdfs/near_ali_dev.uttLen.ref
feat-to-len scp:/mnt/share/srf/FacialCapture/data/fbank_data_24d_seperated/near_fbank_train_new.scp ark,t:- | sort - > alignment/near/pdfs/near_ali_train.uttLen.ref
feat-to-len scp:/mnt/share/srf/FacialCapture/data/fbank_data_24d_seperated/near_fbank_test_new.scp ark,t:- | sort - > alignment/near/pdfs/near_ali_test.uttLen.ref
perl scripts/checkErrorFile.pl alignment/near/pdfs/near_ali_dev.uttLen alignment/near/pdfs/near_ali_dev.uttLen.ref
perl scripts/checkErrorFile.pl alignment/near/pdfs/near_ali_train.uttLen alignment/near/pdfs/near_ali_train.uttLen.ref
perl scripts/checkErrorFile.pl alignment/near/pdfs/near_ali_test.uttLen alignment/near/pdfs/near_ali_test.uttLen.ref

# feat-to-len scp:/mnt/share/srf/FacialCapture/data/fbank_data_24d/near_fbank_dev.scp ark,t:- | sort - > alignment/near/pdfs/near_ali_dev.uttLen.ref
# feat-to-len scp:/mnt/share/srf/FacialCapture/data/fbank_data_24d/near_fbank_train.scp ark,t:- | sort - > alignment/near/pdfs/near_ali_train.uttLen.ref
# perl scripts/combineUttLength.pl alignment/near/pdfs/near_ali_dev.uttLen alignment/near/pdfs/near_ali_dev.uttLen.ref > alignment/near/pdfs/near_ali_dev.uttLen.real
# perl scripts/combineUttLength.pl alignment/near/pdfs/near_ali_train.uttLen alignment/near/pdfs/near_ali_train.uttLen.ref > alignment/near/pdfs/near_ali_train.uttLen.real

# combine post files for multi-task training
paste-post ark:alignment/near/pdfs/near_ali_dev.uttLen 1504:118 ark:alignment/near/pdfs/near_ali_dev.post ark:alignment/near/pdfs/near_mono_ali_dev.post ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_dev_combine_ali.post,alignment/near/pdfs/near_dev_combine_ali.post.scp
paste-post ark:alignment/near/pdfs/near_ali_train.uttLen 1504:118 ark:alignment/near/pdfs/near_ali_train.post ark:alignment/near/pdfs/near_mono_ali_train.post ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_train_combine_ali.post,alignment/near/pdfs/near_train_combine_ali.post.scp
paste-post ark:alignment/near/pdfs/near_ali_test.uttLen 1504:118 ark:alignment/near/pdfs/near_ali_test.post ark:alignment/near/pdfs/near_mono_ali_test.post ark,scp:/mnt/share/srf/FacialCapture/work/alignment/near/pdfs/near_test_combine_ali.post,alignment/near/pdfs/near_test_combine_ali.post.scp

cat alignment/near/pdfs/near_train_combine_ali.post.scp alignment/near/pdfs/near_dev_combine_ali.post.scp alignment/near/pdfs/near_dev_combine_ali.post.scp alignment/near/pdfs/near_test_combine_ali.post.scp > alignment/near/pdfs/near_all_combine_ali.post.scp


# 生成mouth motion所需要的state alignment/near/
# perl scripts/createMouthMotionAlign.pl alignment/near/pdfs/ascii/near_ali_train.pdf > alignment/near/pdfs/ascii/mouth_motion_train_ali.pdf
# perl scripts/createMouthMotionAlign.pl alignment/near/pdfs/ascii/near_ali_dev.pdf > alignment/near/pdfs/ascii/mouth_motion_dev_ali.pdf

# post format
# ali-to-post ark:alignment/near/pdfs/ascii/mouth_motion_train_ali.pdf ark:alignment/near/pdfs/mouth_motion_train_ali.post
# ali-to-post ark:alignment/near/pdfs/ascii/mouth_motion_dev_ali.pdf ark:alignment/near/pdfs/mouth_motion_dev_ali.post

