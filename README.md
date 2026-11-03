# Dockerized CDK Terrain (CDKTN)

## Migration note
HashiCorp [CDK for Terraform](https://developer.hashicorp.com/terraform/cdktf) is deprecated.
This image now ships [CDK Terrain](https://cdktn.io/) (`cdktn`), the community continuation.
See the [v0.22 Python upgrade guide](https://cdktn.io/docs/release/upgrade-guide-v0-22#python).

`cdktf.json`, `cdktf.out/`, and `CDKTF_*` environment variables are unchanged.

## Regular use
Use the published docker image `ghcr.io/asequeira-os/aas-cdktf`

The following commands should be available
- `terraform`
- `cdktn` (`cdktf` is a compatible alias in v0.22)
- `gcloud`
- `python`

See [verify_all](./scripts/verify_all) to see full list

A `docker compose` based usage could look like below
```
services:
  mycdktn:
    image: ghcr.io/asequeira-os/aas-cdktf:latest
    working_dir: /top/mycdktndir
    volumes:
      - /path/to/yourcdkcode:/top
      - /path/to/gcp/creds:/root/.config/gcloud
    command: ["sleep","infinity"]
    environment:
      - SOME_PASSWORD_VAR=mypassword
      - GOOGLE_APPLICATION_CREDENTIALS=/root/.config/gcloud/somecredfile

```

## Development
[cdktn](./cdktn) (or the [cdktf](./cdktf) wrapper) builds the image
and runs it with current dir mounted at `/top`.

To use

- checkout this repo somewhere
- cd to your project that will be using cdktn
- run the cdktn script.

Example:

```
cd ~/mygithubdir
git clone git@github.com:asequeira-os/aas-cdktf.git
cd ~/my-project
mkdir mycdktn
cd mycdktn
~/mygithubdir/aas-cdktf/cdktn
```

New cdktn *project* is started by  
`cdktn init --template=python --local`  
in a new dir under `/top` (project takes dir name).

Help file generated showed the following info:

Compile: Compile and run the python code.  
`pipenv run ./main.py`

Synthesize: Synthesize Terraform resources to `cdktf.out` dir  
`cdktn synth [stack]`

Diff: Perform a diff (terraform plan) for the given stack  
`cdktn diff [stack]`

Deploy: Deploy the given stack  
`cdktn deploy [stack]`

Destroy: Destroy the given stack  
`cdktn destroy [stack]`

More info at <https://cdktn.io/docs>

## Python project migration (from CDKTF)

In `requirements.txt` or `Pipfile`:

```
cdktn>=0.22.0
cdktn-provider-google
```

instead of `cdktf` / `cdktf-cdktf-provider-*`.

Update imports:

```
from cdktn import App, TerraformStack, TerraformOutput
from cdktn_provider_google.provider import GoogleProvider
```

instead of `from cdktf import ...` / `from cdktf_cdktf_provider_google ...`.

Reinstall:

```
pipenv install --dev
```

Providers can be installed using `pipenv`
(simpler than direct `cdktn provider add`).
See <https://pypi.org/project/cdktn/>

Example - `pipenv install cdktn-provider-google`

Notes:

Running `pipenv install` in the generated cdktn project dir
may be needed before running any `cdktn` commands.
