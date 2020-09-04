[![Docker Pulls](https://img.shields.io/docker/pulls/vistalab/acpc-anat.svg)](https://hub.docker.com/r/vistalab/acpc-anat/)
[![Docker Stars](https://img.shields.io/docker/stars/vistalab/acpc-anat.svg)](https://hub.docker.com/r/vistalab/acpc-anat/)


# vistalab/acpc-anat
Build context for a Flywheel Gear to Normalize anatomical NIfTI volumes with the MNI template, or with AC-PC coordinates provided by the user.


### Input
```json
  "inputs": {
    "anatomical": {
      "base": "file",
      "description": "Anatomical T1w NIfTI file.",
      "type": {
        "enum": [
          "nifti"
        ]
      }
    }
```

### Configuration
```json
  "config": {
    "userProvidedAcpc": {
      "default": false,
      "type": "boolean",
      "description": "Use AC-PC coordinates provided by the user in the fields here (true/false, default=false)"
    },
    "AC": {
      "default": "128, 140, 60",
      "type": "string",
      "description": "Anterior Commissure coordinates (DEFAULT='[128, 140, 60]')."
    },
    "PC": {
      "default": "128, 110, 60",
      "type": "string",
      "description": "Posterior Commissure coordinates (DEFAULT='[128, 110, 60]')'."
    },
    "MS": {
      "default": "128, 135, 85",
      "type": "string",
      "description": "Mid Sagittal coordinates (DEFAULT='[128, 135, 85]')'."
    }
```
### Build Docker Image
`docker build -t vistalab/acpc-anat .`
