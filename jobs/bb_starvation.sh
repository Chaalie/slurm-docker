#!/bin/bash

sbatch --bb="capacity=10G access=striped type=scratch" -N 1 -t 45 --job-name=sleep-45 sleep.job 45
sbatch --bb="capacity=20G access=striped type=scratch" -N 1 -t 30 --job-name=starved sleep.job 30
sbatch --bb="capacity=10G access=striped type=scratch" -N 1 -t 30 --job-name=sleep-30 --array=1-4 sleep.job 30
