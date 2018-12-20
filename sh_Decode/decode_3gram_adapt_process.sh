#!/bin/sh

# test
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_results.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/test/version1/decode_SIandSS_cmp.LOG

# mci
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_results.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_all4M_addSF.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/mci/version1/decode_SIandSS_cmp.LOG

# ad
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_ad_v4.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_results.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_ad_v4.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_results_PD.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_PD_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_ad_v4.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_results_SR.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_SR_cmp.LOG
HResults -e ??? sil -e ??? sp -h -A -D -T 1 -I /mnt/shareEx/panjingshen/ElderVoice/DATA/scripts/standard_ad_v4.mlf /mnt/shareEx/jingan/LDC/LDC1/work/S2_6000_hlda_3p/xwrd.clustered.mlist /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_results_SIandSS.mlf > /mnt/shareEx/panjingshen/ElderVoice/DECODE/adapt/ad/version1/decode_SIandSS_cmp.LOG