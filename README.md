# Scripts
All kinds of scripts to make life easier and to mess around

#Bash

## [manage-git.sh](./Bash/manage-git.sh)

This script automatically clones all repos from Github (and Gitlab WIP) to the local machine and writes them to a tarball (option to not do this WIP).

### Structure

* reops
  * Author 1
    * Repo 1
    * Repo 2
    * etc.
  * Author 2
    * Repo 1
    * Repo 2
    * etc.
  * etc.
    * Repo 1
    * Repo 2
    * etc.

### Usage

Run the following command with any of the following flags

```bash
./manage-git.sh [options] [FLAG]
````

Options and flags

| Options | Input Type | Description | 
| --- | --- | --- |
| -t | String | Specifies the personal access token the script should use |

| Flags | Description | 
| --- | --- | 
| -p | Runs the script using https protocol |
| -k | Runs the script using ssh protocol |
| -c | Runs the script and compresses the results into a tarball (TODO) |
| -z | Runs the script and compresses the results into a zip (TODO) |