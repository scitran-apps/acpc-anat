[![Docker Pulls](https://img.shields.io/docker/pulls/vistalab/dwi-flip-bvec.svg)](https://hub.docker.com/r/vistalab/dwi-flip-bvec/)
[![Docker Stars](https://img.shields.io/docker/stars/vistalab/dwi-flip-bvec.svg)](https://hub.docker.com/r/vistalab/dwi-flip-bvec/)


# vistalab/dwi-flip-bvec
Flip the sign of the bvec vector in the specified vector(s).

### Build Docker Image
`docker build -t vistalab/dwi-flip-bvec .`


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
       vistalab/dwi-flip-bvec
```

The results will be:
```.
├── input
│   ├── bvec
│   │   └── 101915_dwi.bvec
├── output
│   ├── 101915_dwi_1000.bvec
```
