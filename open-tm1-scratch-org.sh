#!/bin/bash

openScratchOrg () {
  # Opens the specified scratch org.
  case $1 in
    ''|*[!1-5]*) 
      echo ""
      echo "Must provide a number between 1 and 5 as the first argument to open-tm1-scratch-org.sh. Aborting Script."
      exit 1;;
  esac
  SCRATCH_ORG_ALIAS="TestDrive$1:tm1-scratch-org"
  if [ ! -z $2 ]; then
    ORG_PATH_TO_OPEN="-p $2"
  else
    ORG_PATH_TO_OPEN=""
  fi
  echo ""
  echo "Executing force:org:open -u $SCRATCH_ORG_ALIAS $ORG_PATH_TO_OPEN"
  sfdx force:org:open -u $SCRATCH_ORG_ALIAS $ORG_PATH_TO_OPEN
  echo ""
  echo "------------------------------"
}

# Open the specified scratch org 
echo ''
openScratchOrg $1 lightning/setup/SetupOneHome/home
echo ''
