#!/bin/bash

## version
tag=1.0.3

## build and push online
docker build -t vistalab/acpc-anat:$tag ./
