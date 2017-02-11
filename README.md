# Templates for creating bioboxes
How to build a custom docker image using bioboxes. Why would you want to use docker or bioboxes?....please read the two links below
and become familier with docker first. This documentation is not meant to be a tutorial on docker or bioboxes, rather a description
of one way you could quickly set up your environment and file structure to build an image that employs biobox infrastructure.
Hopefully the templates will minimize the number of lines of code you need to change.

For more information see
[docker docs](https://docs.docker.com)
[bioboxes docs](http://bioboxes.org/docs)

## flow of events
1) when you build a new image, the Dockerfile is executed first which runs the install.sh script, sets
a few variables, and tells docker what script to run after everything is set up (i.e in this case it runs "assemble.sh").
2) the install.sh script downloads all dependencies through apt-get packages and compiles everything.
3) whatever is set to be the executable in the Dockerfile is run next, i.e. see line in Dockerfile:
`ENV BIOBOX_EXEC  assemble.sh`
assemble.sh is run with or without an argument. If it is suppose to have an argument, this is defined
in the `Taskfile`. And if there are any arguments defined in the Taskfile, then it will be included
in the commandline when you run the image (see "run your image" below).
Note there is only one defined argument option in this Taskfile called "default".

## I. first things first
clone the templates
```
git clone git@gitlab.com:jfroula/bioboxtemplate.git
cd bioboxtemplate
```

## II. Copy input date into input_data
```
cp ../reads.fq.gz input_data/
```

## III. customize the following files
##### You need to make the name(s) in biobox.yaml compatible with the reads/data you copied into input_data
`input_data/biobox.yaml`
you can read more about the biobox.yaml here [biobox.yaml](http://bioboxes.org/docs/validate-biobox-file/)

##### You need to customize Dockerfile. This file sets up the environment and directory structure of the container
`Dockerfile`
(see [what are Dockerfiles](https://docs.docker.com/engine/getstarted/step_four)
Note that my Dockerfile simply runs an install.sh script to do all the setup work for it, but the Dockerfile
typically would include all the contents of the install.sh script. Of course the syntax would be Dockerfile syntax
instead of bash.

##### add options for running your image
`share/Taskfile`
[creating task options](http://bioboxes.org/docs/create-a-task)

##### customize install.sh to install all dependencies and assemble.sh to run your program
`bin/assemble.sh`
`bin/install.sh`

## IV. build your image
and notice the dot at the end of this command specifying path to Dockerfile
```
docker build --tag <whatever-you-want-to-call-it> .
```

## V. run your image with an interactive bash (i.e. to debug and see what the images environment is)
```
docker run  \
  --volume="$(pwd)/output_data:/bbx/output:rw" \
  --volume="$(pwd)/input_data:/bbx/input:ro" \
  --entrypoint=/bin/bash -it <whatever-you-called-it>
```
you could test run everything by typing "assemble.sh default"

### VI. run your image
```
docker run \
  --volume="$(pwd)/input_data:/bbx/input:ro" \
  --volume="$(pwd)/output_data:/bbx/output:rw" \
  --rm \
  <whatever-you-called-it> <argument defined in Taskfile: i.e. "default">
```
### VII. check your output
all output should be in "output_data"


