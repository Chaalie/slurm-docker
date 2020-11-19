#!/bin/bash
set -e

echo "Starting MUNGE service..."
sudo -u munge /usr/sbin/munged

echo "Waiting for Slurm database..."
until 2>/dev/null >/dev/tcp/slurm-db/6819
    do
        echo "Waiting for Slurm database to become active..."
        sleep 2
    done
echo "Slurm database is now available..."

echo "Starting Slurm Controller Daemon..."
exec sudo -u slurm slurmctld -Dvvv
