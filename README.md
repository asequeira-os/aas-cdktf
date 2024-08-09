# Dockerized Terraform CDK

## Regular use
Use the published docker image `ghcr.io/asequeira-os/aas-cdktf`

The following commands should be available
- `terraform` 
- `cdktf`
- `gcloud`
- `python`

See [verify_all](./scripts/verify_all) to see full list

A `docker compose` based usage could look like below
```
services:
  mycdktf:
    image: ghcr.io/asequeira-os/aas-cdktf:latest
    working_dir: /top/mycdktfdir
    volumes:
      - /path/to/yourcdkcode:/top
      - /path/to/gcp/creds:/root/.config/gcloud
    command: ["sleep","infinity"]
    environment:
      - SOME_PASSWORD_VAR=mypassword
      - GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/somecredfile

```

## Development
[cdktf](./cdktf) script creates the image
and runs it with current dir mounted at `/top`.

To use

- checkout this repo somewhere
- cd to your project that will be using cdktf
- run the cdktf script.

Example:

```
cd ~/mygithubdir
git clone git@github.com:asequeira-os/aas-cdktf.git
cd ~/my-project
mkdir mycdktf
cd mycdktf
~/mygithubdir/aas-cdktf/cdktf
```

New cdktf *project* is started by  
`cdktf init --template=python --local`  
in a new dir under `/top` (project takes dir name).

Help file generated showed the following info:

Compile: Compile and run the python code.  
`pipenv run ./main.py`

Synthesize: Synthesize Terraform resources to `cdktf.out` dir  
`cdktf synth [stack]`

Diff: Perform a diff (terraform plan) for the given stack  
`cdktf diff [stack]`

Deploy: Deploy the given stack  
`cdktf deploy [stack]`

Destroy: Destroy the given stack  
`cdktf destroy [stack]`

More info at <https://cdk.tf/modules-and-providers>

Providers can be installed using `pipenv`
(simpler than direct `cdktf provider add`).
See <https://pypi.org/user/cdktf-team/>

Example - `pipenv install cdktf-cdktf-provider-google`

Notes:

Running `pipenv install` in the generated cdktf project dir
may be needed befor running any `cdktf` commands.
