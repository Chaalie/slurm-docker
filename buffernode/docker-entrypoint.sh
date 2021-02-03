#!/bin/bash
set -e

echo "Waiting for etcd..."
until 2>/dev/null >/dev/tcp/etcd/2379
    do
        echo "Waiting for etcd to become active..."
        sleep 2
    done
echo "Etcd is now available..."

echo "Starting burst buffer node..."
exec dacd
