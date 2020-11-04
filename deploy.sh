#!/bin/bash
# OMIT_FLAG_04:7o7h8pxtn3bghzcy0olhr546jpxgp8sa
source env.sh

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/id_rsa # Allow read access to the private key
ssh-add .travis/id_rsa # Add the private key to SSH

git config --global push.default matching
git remote add deploy git@github.com:omitjohngonzales/coronaPortal.git
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
ssh apps@$IP -p $PORT <<EOF
  cd $DEPLOY_DIR
  crystal build --release --no-debug index.cr # Change to whatever commands you need!
EOF
