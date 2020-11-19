#!/bin/bash

sbatch -N 1 -t $1 --job-name=sleep-$1 sleep.job $1
