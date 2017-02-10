#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

# This used JQ syntax to fetch the fastq entries from the biobox.yaml file
READS=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | join(" ")')

# Fetch the task provided, for example this if the user provides the task "default"
# the args you have defined /usr/local/share/biobox/Taskfile are returned. This
# allows to create different ways of running the software.
FLAGS=$(fetch_task_from_taskfile.sh ${TASKFILE} $1)


# Insert the code to run the software here ...

# All bioboxes must create an output biobox.yaml file in addition to the one
# provided by the user. The code below simply `cat`s the output to
# /bbx/output/biobox.yaml
cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:

  # List your generated outputs in yaml syntax

EOF
