[![Docker Pulls](https://img.shields.io/docker/pulls/scitran/dwi-flip-bvec.svg)](https://hub.docker.com/r/scitran/dwi-flip-bvec/)
[![Docker Stars](https://img.shields.io/docker/stars/scitran/dwi-flip-bvec.svg)](https://hub.docker.com/r/scitran/dwi-flip-bvec/)


# scitran/dwi-flip-bvec
Flip the sign of the bvec vector in the specified vector(s).

### Build Docker Image
`docker build -t scitran/dwi-flip-bvec .`


### Run Locally
Assumes data are in a local directory in the following layout (note the `input` and `output` parent directories):
```.
├── input
│   ├── bvec
│   │   └── 101915_dwi.bvec
├── output
```
Then run the container:
```
docker run -it --rm \
       -v `pwd`/input:/flywheel/v0/input/ \
       -v `pwd`/output/:/flywheel/v0/output/ \
       scitran/dwi-flip-bvec
```

The results will be:
```.
├── input
│   ├── bvec
│   │   └── 101915_dwi.bvec
├── output
│   ├── 101915_dwi_1000.bvec
```
