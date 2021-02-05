#!/bin/bash


sbatch -L test:1 -N 1 -t 8 --job-name=sleep-8 sleep.job 8
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:2 -N 1 -t 5 --job-name=licenses-2 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
sbatch -L test:1 -N 1 -t 5 --job-name=sleep-5 sleep.job 5
