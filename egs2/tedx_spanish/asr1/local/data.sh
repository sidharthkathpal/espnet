#!/usr/bin/env bash

# Copyright 2020 Johns Hopkins University (Shinji Watanabe)
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

. ./path.sh || exit 1;
. ./cmd.sh || exit 1;
. ./db.sh || exit 1;

# general configuration
stage=0       # start from 0 if you need to start from data preparation
stop_stage=100
SECONDS=0
lang=es # en de fr cy tt kab ca zh-TW it fa eu es ru tr nl eo zh-CN rw pt zh-HK cs pl uk 

 . utils/parse_options.sh || exit 1;

# base url for downloads.
data_url=https://www.openslr.org/resources/67/tedx_spanish_corpus.tgz

log() {
    local fname=${BASH_SOURCE[1]##*/}
    echo -e "$(date '+%Y-%m-%dT%H:%M:%S') (${fname}:${BASH_LINENO[0]}:${FUNCNAME[1]}) $*"
}

mkdir -p ${TEDX_SPANISH}
if [ -z "${TEDX_SPANISH}" ]; then
    log "Fill the value of 'TEDX_SPANISH' of db.sh"
    exit 1
fi

# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set=train_"$(echo "${lang}" | tr - _)"
train_dev=dev_"$(echo "${lang}" | tr - _)"
test_set=test_"$(echo "${lang}" | tr - _)"

log "data preparation started"

if [ ${stage} -le 0 ] && [ ${stop_stage} -ge 0 ]; then 
    log "stage1: Download data to ${TEDX_SPANISH}"
    log "The default data of this recipe is from TEDX_SPANISH https://www.openslr.org/67"
    local/download_and_untar.sh ${TEDX_SPANISH} ${data_url} tedx_spanish_corpus.tgz
fi

if [ ${stage} -le 1 ] && [ ${stop_stage} -ge 1 ]; then
    log "stage2: Preparing data for TEDX_SPANISH"
    ### Task dependent. You have to make data the following preparation part by yourself.
    python local/data_transcript.py "${TEDX_SPANISH}"
    
    for part in "train" "test" "dev"; do
        # use underscore-separated names in data directories.
        local/data_prep.pl "${TEDX_SPANISH}/tedx_spanish_corpus" ${part} data/"$(echo "${part}_${lang}" | tr - _)"
    done

fi

log "Successfully finished. [elapsed=${SECONDS}s]"
