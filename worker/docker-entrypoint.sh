#!/bin/bash
set -e

echo "Starting MUNGE service..."
sudo -u munge /usr/sbin/munged

echo "Waiting for Slurm controller..."
until 2>/dev/null >/dev/tcp/slurm-controller/6817
    do
        echo "Waiting for Slurm controller to become active..."
        sleep 2
    done
echo "Slurm controller is now available..."

echo "Starting Slurm Node Daemon..."
exec sudo -u slurm slurmd -Dvvv
