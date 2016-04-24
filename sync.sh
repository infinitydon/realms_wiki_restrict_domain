#!/bin/bash

## Script to update remote repo on the git server after Gollum makes any update, it also pulls new content from the git server 
 
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
(cd $DIR && git pull && git push)
