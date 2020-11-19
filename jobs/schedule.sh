#!/bin/bash

R=$(($RANDOM%10+1))
N=$(($RANDOM%2+1))

sbatch -N $N -t $R --job-name=sleep-$R sleep.job $R
