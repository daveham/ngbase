#!/usr/bin/env bash

project='ngbase'

# create ssh-config file
parentdir="$(dirname `pwd`)"
ssh_config="${parentdir}/.vagrant/ssh-config"
vagrant ssh-config > "${ssh_config}"

# create unison profile for the project
root_host="${parentdir}"
root_vm="ssh://default//${project}/"

# ? dontchmod = true

profile1="
root = $root_host
root = $root_vm
ignore = Path vagrantfiles
ignore = Name {Vagrantfile,*.md,LICENSE,*.log}
ignore = Name {*.sublime-project,*.sublime-workspace}
ignore = Name {.idea,.vagrant,.git,node_modules,lib,.DS_Store}
prefer = $root_host
repeat = 2
terse = true
perms = 0
sshargs = -F $ssh_config
"


# write profiles

if [ -z ${USERPROFILE+x} ]; then
  UNISONDIR=$HOME
else
  UNISONDIR=$USERPROFILE
fi

cd $UNISONDIR
[ -d .unison ] || mkdir .unison
echo "$profile1" > ".unison/${project}.prf"
