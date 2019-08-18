#!/bin/bash
# Specify the alias or username associated with your connection to the TM-Tools Test Drive DevHub.
DEV_HUB_ALIAS="DevHub-PBO"

# You SHOULD NOT need to change anything below this line.
PROJECT_ROOT="."
SCRATCH_ORG_CONFIG="${PROJECT_ROOT}/config/tm1-scratch-def.json"
SCRATCH_ORG_EXPIRATION_DAYS="30"
SCRATCH_ORG_WAIT_TIME="10"
API_VERSION="46.0"

createScratchOrg() {
  # Create a new scratch org using the scratch-def.json locally configured for this project. 
  if [ ! -z $1 ]; then
    SCRATCH_ORG_ALIAS="$1"
  else
    echo ""
    echo "Must provide a Scratch Org Alias as the first argument to createScratchOrg(). Aborting Script."
    exit 1
  fi
  echo "Executing force:org:create -f $SCRATCH_ORG_CONFIG -a $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS -s -d $SCRATCH_ORG_EXPIRATION_DAYS -w $SCRATCH_ORG_WAIT_TIME --apiversion $API_VERSION --json"
  echo ""
  echo "Scratch org creation may take several minutes. Please be patient."
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:org:create -f $SCRATCH_ORG_CONFIG -a $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS -s -d $SCRATCH_ORG_EXPIRATION_DAYS -w $SCRATCH_ORG_WAIT_TIME --apiversion $API_VERSION --json)
  if [ $? -ne 0 ]; then
    echo ""
    echo "Scratch org could not be created. Aborting Script."
    exit 1
  fi
  echo ""
  echo "------------------------------"
}

deleteScratchOrg () {
  # Delete the current scratch org.
  if [ ! -z $1 ]; then
    SCRATCH_ORG_ALIAS="$1"
  else
    echo ""
    echo "Must provide a Scratch Org Alias as the first argument to deleteScratchOrg(). Aborting Script."
    exit 1
  fi
  echo "Executing force:org:delete -p -u $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS --json"
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:org:delete -p -u $SCRATCH_ORG_ALIAS -v $DEV_HUB_ALIAS --json)
  if [ $? -ne 0 ]; then
    echo ""
    echo "The alias $SCRATCH_ORG_ALIAS did not previously exist. You can ignore the error this caused."
  fi
  echo ""
  echo "------------------------------"
}

generatePassword () {
  # Generates a password for the admin user of the scratch org. Necessary to use workbench.
  if [ ! -z $1 ]; then
    SCRATCH_ORG_ALIAS="$1"
  else
    echo ""
    echo "Must provide a Scratch Org Alias as the first argument to generatePassword(). Aborting Script."
    exit 1
  fi
  echo "Executing force:user:password:generate -u $SCRATCH_ORG_ALIAS --json"
  echo ""
  sfdx force:user:password:generate -u $SCRATCH_ORG_ALIAS --json
  echo ""
  echo "------------------------------"
}

openScratchOrg () {
  # Opens the specified scratch org.
  echo "Executing force:org:open -u $SCRATCH_ORG_ALIAS"
  echo ""
  if [ ! -z $1 ]; then
    ORG_PATH_TO_OPEN="-p $1"
  else
    ORG_PATH_TO_OPEN=""
  fi
  sfdx force:org:open -u $SCRATCH_ORG_ALIAS $ORG_PATH_TO_OPEN
  echo ""
  echo "------------------------------"
}

pushSfdxSource () {
  # Pushes SFDX Source from the current projet to the specified scratch org.
  if [ ! -z $1 ]; then
    SCRATCH_ORG_ALIAS="$1"
  else
    echo ""
    echo "Must provide a Scratch Org Alias as the first argument to pushSfdxSource(). Aborting Script."
    exit 1
  fi
  echo "Executing force:source:push -u $SCRATCH_ORG_ALIAS"
  echo ""
  (cd $PROJECT_ROOT && exec sfdx force:source:push -u $SCRATCH_ORG_ALIAS --json)
  echo ""
  echo "------------------------------"
}


# 1. Delete old TM1 scratch orgs (if they exist)
# 2. Create new TM1 scratch orgs
# 3. Generate a password for the admin user
# 4. Push SFDX Source to scratch orgs
echo ''
deleteScratchOrg "TestDrive1:tm1-scratch-org"
deleteScratchOrg "TestDrive2:tm1-scratch-org"
deleteScratchOrg "TestDrive3:tm1-scratch-org"
deleteScratchOrg "TestDrive4:tm1-scratch-org"
deleteScratchOrg "TestDrive5:tm1-scratch-org"

echo ''
createScratchOrg "TestDrive1:tm1-scratch-org"
createScratchOrg "TestDrive2:tm1-scratch-org"
createScratchOrg "TestDrive3:tm1-scratch-org"
createScratchOrg "TestDrive4:tm1-scratch-org"
createScratchOrg "TestDrive5:tm1-scratch-org"

echo ''
generatePassword "TestDrive1:tm1-scratch-org"
generatePassword "TestDrive2:tm1-scratch-org"
generatePassword "TestDrive3:tm1-scratch-org"
generatePassword "TestDrive4:tm1-scratch-org"
generatePassword "TestDrive5:tm1-scratch-org"

echo ''
pushSfdxSource "TestDrive1:tm1-scratch-org"
pushSfdxSource "TestDrive2:tm1-scratch-org"
pushSfdxSource "TestDrive3:tm1-scratch-org"
pushSfdxSource "TestDrive4:tm1-scratch-org"
pushSfdxSource "TestDrive5:tm1-scratch-org"

echo ''
