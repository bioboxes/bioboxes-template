FROM bioboxes/biobox-minimal-base@sha256:b73428dee585232350ce0e30d22f97d7d22921b74b81a4196d246ca2da3cb0f5

ADD image /usr/local

RUN install.sh && rm /usr/local/bin/install.sh

# Define the location of the file which describes the different ways the software
# can be run
ENV TASKFILE     /usr/local/share/biobox/Taskfile

# This describes the location of the schema file. Each schema file is used to
# validate the arguments given by the user. There are different schema files
# depending on the type of biobox task. For example short_read_assembly or
# assembly evaluation
ENV SCHEMA       /usr/local/share/biobox/ADD_A_SCHEMA_FILE

# Specify the the script which runs the software when the image is executed. This
# script can be found in ./image/bin/ in this repository
ENV BIOBOX_EXEC  execute_biobox.sh
