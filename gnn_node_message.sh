#!/bin/bash
# ./gnn_node_message.sh rel-f1 driver-position 0
# ./gnn_node_message.sh rel-f1 driver-top3 0 drivers,qualifying,standings,results

DATASET=$1
TASK=$2
GPU=$3
TAG=$4
RESULTS_DIR="./results"
if [ ! -d "$RESULTS_DIR/$DATASET/$TASK" ]; then
    mkdir -p "$RESULTS_DIR/$DATASET/$TASK"
fi

for SEED in 0 1 2 3 4
do
    if [ -z "$TAG" ]; then
        CUDA_VISIBLE_DEVICES=$GPU python ../gnn_node_message.py --dataset $DATASET --task $TASK --seed $SEED > ./$RESULTS_DIR/${DATASET}/${TASK}/${SEED}.txt
    else
        CUDA_VISIBLE_DEVICES=$GPU python ../gnn_node_message.py --keep_tables $TAG --dataset $DATASET --task $TASK --seed $SEED > ./$RESULTS_DIR/${DATASET}/${TASK}/${SEED}_${TAG}.txt
    fi
done
