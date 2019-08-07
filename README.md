# TM-Tools Test Drive

This repository enables invited users to test-drive the Territory Management Tools (TM-Tools) CLI plugin. 

This "test drive" provides a controlled setting in which users can get a feel for the TM1-to-TM2 migration process and see first-hand how the TM-Tools plugin can be used to make things easier.

## PART ONE: Preparing Your Environment

Before getting started, you'll need to prepare your "test drive" environment by following these steps.

**IMPORTANT:** The TM-Tools plugin only supports MacOS. These instructions may not work on other platforms (ie. Windows or Linux)

### Step 1: Make sure that the Salesforce CLI and Git are installed on your local machine

Both the Salesforce CLI and Git must be installed on your machine before you can proceed. 

If you don't already have both of these installed, please see the following guides for assistance:

* Learn how to [Install the Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm) from the Salesforce DX Developer Guide
* Learn how to [Set Up Git](https://help.github.com/articles/set-up-git/) from the GitHub Help site

### Step 2: Request access to the TM-Tools DevHub
Details TBD

### Step 3: Authenticate your CLI to the TM-Tools Test Drive DevHub
Using the credentials provided to you after requesting access to the TM-Tools Test Drive DevHub, authenticate your CLI to that DevHub using the following command

```shell
sfdx force:auth:web:login -a DevHub:tm-tools-test-drive
```

### Step 4: Clone this repository to your local machine
Clone the `tm-tools-test-drive` repository to your local machine using the following command:

```shell
git clone https://github.com/sfdx-isv/tm-tools-test-drive.git
```

Once you've cloned this repository, navigate into the `tm-tools-test-drive` directory using the following command:

```shell
cd tm-tools-test-drive
```

### Step 5: Customize the scratch org build script for your environment

Open the file `build-tm1-scratch-org.sh` in a text/code editor. Make sure that the value set for `DEV_HUB_ALIAS` on line 3 matches the alias or username you specified in **Step 3** when you authenticated your CLI to the TM-Tools Test Drive DevHub.

If you followed **Step 3** exactly as written, line 3 of `build-tm1-scratch-org.sh` will look exactly like this:

```sh
DEV_HUB_ALIAS="DevHub:tm-tools-test-drive"
```

### Step 6: Build a TM-Tools Test Drive scratch org using the shell script

Execute the following command to build a TM-Tools Test Drive scratch org:
```shell
./build-tm1-scratch-org.sh
```

This command will run multiple steps and can take 5-10 minutes to complete.  You'll know the process is complete once the CLI opens a Salesforce org in your default browser that looks like this:

**TBD: INSERT SCREEN SHOT OF TM1 ORG**

#### Make note of the password for this org (optional)
The `build-tm1-scratch-org.sh` script generates a password for the org's default admin user. This may be useful if you plan to connect to this org with outside tools, like Workbench.

The password can be found in the section of shell output that looks like this:

```shell
------------------------------

Executing force:user:password:generate -u TestDrive:tm1-scratch-org --json

{
  "status": 0,
  "result": {
    "password": "2Gmz@8^BbY"
  }
}

------------------------------
```

### Step 7: Install the Territory Management Tools (TM-Tools) plugin

To install the Territory Management Tools (TM-Tools) plugin, execute the following command:

```shell
sfdx plugins:install territory-management-tools
```


## PART TWO: Migrating from Territory Management (TM1) to Enterprise Territory Management (TM2)

Before following the steps in this section, make sure you're at the root of the `tm-tools-test-drive` repository on your local machine.

To do this, execute the `pwd` command. Your output should look something like this:

```shell
/Users/vchawla/sfdx-isv/tm-tools-test-drive
```

If the output to the **right** of the last `/` character is not `tm-tools-test-drive`, then you will need to find that directory in your local environment and navigate to it.


### Step 1: Analyze

Details TBA

```shell
sfdx tmtools:tm1:analyze -d MIGRATION_TEST
```

### Step 2: Extract

Details TBA

```shell
sfdx tmtools:tm1:extract -s MIGRATION_TEST
```

### Step 3: Transform

Details TBA

```shell
sfdx tmtools:tm1:transform -s MIGRATION_TEST
```

### Step 4: Clean

Details TBA

```shell
sfdx tmtools:tm1:clean -s MIGRATION_TEST
```

### Step 5: Deploy

Details TBA

```shell
sfdx tmtools:tm2:deploy -s MIGRATION_TEST
```

### Step 6: Load

Details TBA

```shell
sfdx tmtools:tm2:load -s MIGRATION_TEST
```
