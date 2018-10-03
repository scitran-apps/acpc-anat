#!/bin/bash

## version
tag=1.0.0

## build and push online
docker build -t scitran/acpc-anat:$tag ./
