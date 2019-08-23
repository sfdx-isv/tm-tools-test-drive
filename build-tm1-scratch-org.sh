#!/bin/bash
# Specify the alias or username associated with your connection to the TM-Tools Test Drive DevHub.
DEV_HUB_ALIAS="DevHub:TMT-Test-Drive"

# You SHOULD NOT need to change anything below this line.
PROJECT_ROOT="."
SCRATCH_ORG_CONFIG="${PROJECT_ROOT}/config/tm1-scratch-def.json"
SCRATCH_ORG_ALIAS="TestDrive:tm1-scratch-org"
SCRATCH_ORG_EXPIRATION_DAYS="2"
SCRATCH_ORG_WAIT_TIME="10"
API_VERSION="46.0"

createScratchOrg() {
  # Create a new scratch org using the scratch-def.json locally configured for this project. 
  echo "Creating scratch org $SCRATCH_ORG_ALIAS using $DEV_HUB_ALIAS."
  echo ""
  echo "Scratch org creation may take several minutes. Please be patient."
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:org:create -f $SCRATCH_ORG_CONFIG -a $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS -s -d $SCRATCH_ORG_EXPIRATION_DAYS -w $SCRATCH_ORG_WAIT_TIME --apiversion $API_VERSION --json  --json > /dev/null 2>&1)
  if [ $? -ne 0 ]; then
    echo ""
    echo "Scratch org could not be created. Aborting Script."
    exit 1
  fi
  echo "------------------------------"
}

deleteScratchOrg () {
  # Delete the current scratch org.
  echo "Deleting scratch org $SCRATCH_ORG_ALIAS (if present)"
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:org:delete -p -u $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS --json > /dev/null 2>&1)
  echo "------------------------------"
}

generatePassword () {
  # Generates a password for the admin user of the scratch org. Necessary to use workbench.
  echo "Generating password for $SCRATCH_ORG_ALIAS (useful if you want to use non-CLI tools)"
  echo ""
  sfdx force:user:password:generate -u $SCRATCH_ORG_ALIAS --json
  echo ""
  echo "------------------------------"
}

openScratchOrg () {
  # Opens the specified scratch org.
  if [ ! -z $1 ]; then
    ORG_PATH_TO_OPEN="-p $1"
  else
    ORG_PATH_TO_OPEN=""
  fi
  echo "Opening scratch org $SCRATCH_ORG_ALIAS"
  echo ""
  sfdx force:org:open -u $SCRATCH_ORG_ALIAS $ORG_PATH_TO_OPEN
  echo ""
  echo "------------------------------"
}

pushSfdxSource () {
  # Pushes SFDX Source from the current projet to the specified scratch org.
  echo "Pushing basic org config to $SCRATCH_ORG_ALIAS"
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:source:push -u $SCRATCH_ORG_ALIAS --json > /dev/null 2>&1)
  echo "------------------------------"
}


# 1. Delete the old TM1 scratch org (if it exists)
# 2. Create a new TM1 scratch org
# 3. Generate a password for the admin user
# 4. Open the newly created TM1 scratch org
echo ''
deleteScratchOrg

echo ''
createScratchOrg

echo ''
generatePassword

echo ''
pushSfdxSource

echo ''
openScratchOrg lightning/setup/Territories/home

echo ''
