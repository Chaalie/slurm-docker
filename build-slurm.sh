#!/bin/bash

(cd slurm && make)
docker build -f base/Dockerfile -t slurm-base .
docker-compose build
