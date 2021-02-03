#!/bin/bash
set -e

echo "Starting MUNGE service..."
sudo -u munge /usr/sbin/munged

echo "Waiting for etcd..."
until 2>/dev/null >/dev/tcp/etcd/2379
    do
        echo "Waiting for etcd to become active..."
        sleep 2
    done
echo "Etcd is now available..."

echo "Waiting for Slurm database..."
until 2>/dev/null >/dev/tcp/slurm-db/6819
    do
        echo "Waiting for Slurm database to become active..."
        sleep 2
    done
echo "Slurm database is now available..."

echo "Starting Slurm Controller Daemon..."
exec slurmctld -Dvvv
