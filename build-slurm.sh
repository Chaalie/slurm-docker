#!/bin/bash
set -e

(cd slurm && make)
docker build -f base/Dockerfile -t slurm-base .
docker-compose build
