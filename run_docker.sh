#!/bin/bash
docker run --rm -it \
		-v /black/localhome/glerma/soft/acpc-anat/config.json:/flywheel/v0/config.json \
        -v /black/localhome/glerma/TESTDATA/acpcAnat/input:/flywheel/v0/input \
        -v /black/localhome/glerma/TESTDATA/acpcAnat/output:/flywheel/v0/output \
        vistalab/acpc-anat:1.0.0
