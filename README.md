# Dockerized Terraform CDK

[cdktf](./cdktf) (temporary script) creates the image
and runs it with this git repo dir mounted at `/top`.

But the generated docker image should be usable (once stable)
for multiple `cdktf` projects by running it with the actual
project mounted at `/top`.

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
