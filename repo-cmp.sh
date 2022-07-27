#!/bin/bash

echo 'this is repo-cmp.sh'

<<'INPUT'
  source_repo:
    description: GitHub public repo slug or full https clone url (with access_token if needed)
    required: true
  destination_repo:
    description: Repo name to sync to in this repo. default to who runed this action.
    default: '${{ github.repository }}'
    required: false
  source_branch:
    description: Branch name to sync from
    required: false
  destination_branch:
    description: Branch name to sync to in this repo
    required: false
  sync_tags:
    description: Should tags also be synced
    required: false
  destination_repo_from_file:
    description: Set to true if destination_repo specs a file that contains latest result of `git ls-remote`
    required: false
INPUT

echo "source_repo:$INPUT_SOURCE_REPO"
echo "destination_repo:$INPUT_DESTINATION_REPO"
echo "source_branch:$INPUT_SOURCE_BRANCH"
echo "destination_branch:$INPUT_DESTINATION_BRANCH"
echo "sync_tags:$INPUT_SYNC_TAGS"
echo "destination_repo_from_file:$INPUT_DESTINATION_REPO_FROM_FILE"

source_raw=`git ls-remote -h -q $INPUT_SOURCE_REPO`
dest_raw=''
if [[ $INPUT_DESTINATION_REPO_FROM_FILE == 'true' ]]; then
    echo 'import from file: '$INPUT_DESTINATION_REPO
fi