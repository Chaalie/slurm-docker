#!/bin/bash
set -e

echo "Starting MUNGE service..."
sudo -u munge /usr/sbin/munged

echo "Waiting for MySQL database ..."
{
    . /etc/slurm/slurmdbd.conf
    until echo "SELECT 1" | mysql -h $StorageHost -u$StorageUser -p$StoragePass 2>&1 > /dev/null
    do
        echo "Waiting for database to become active..."
        sleep 2
    done
}
echo "Database is now available..."

echo "Starting Slurm DB Daemon..."
exec slurmdbd -Dvvv
