Organization repository backup script

Developed by PS-Professional

     ____  ____        ____             __               _                   _
    |  _ \/ ___|      |  _ \ _ __ ___  / _| ___  ___ ___(_) ___  _ __   __ _| |
    | |_) \___ \ _____| |_) | '__/ _ \| |_ / _ \/ __/ __| |/ _ \| '_ \ / _` | |
    |  __/ ___) |_____|  __/| | | (_) |  _|  __/\__ \__ \ | (_) | | | | (_| | |
    |_|   |____/      |_|   |_|  \___/|_|  \___||___/___/_|\___/|_| |_|\__,_|_|

## What is this project?

This project will clone and craete backup from your organization repositories. The `repo-backup.sh` script first make a request to Github API and get data about projects using your credits. After that, it will search through requested data and use `ssh_url` variable to clone them into `./tmp` directory using SSH. Then it will start archiving and compressing (using XZ) each project. After that, it will again archive and compress projects into single file. After each level done, script will remove last level files to keep your storage clean and free. The final file name is `GithubRepos([day][month-abbrviation][year]).tar.xz`

## Requirements of this project

Before using this ptoject, make sure you have some options available on your GitHub account. First, this project uses SSH conections to clone projects so check [your account SSH configurations](https://github.com/settings/keys) if it is available and valid. After that, you need to create a Github API token to access to Github API using it. If you don't have any, you can create it from [Github account settings](https://github.com/settings/tokens). Note that your access token onle need `read:org` permission from `admin:org` section. With these two options available on your account, now you can create a backup file from your file.

##  How to use the script?

To run the script, use this command:
```
./repo-backup.sh
```
At first usage of this script, it will ask you your Githun username, organization name (Note that both are case sensitive!) and your personal access token. Let's take a look at example below:
~~~ shell
╭─parsa@PS-Pro ~/Organization-Backup
╰─$ ./repo-backup.sh
Welcome to Organization Backup scrpit!
Developed by PS-Professional
Let's start! :)
This script need your information to perform backup task
Please enter tour Github username: My_user
Please enter tour Github organization name: My_Organization
Please enter tour Github token : My_Personal_Access_Token
Do you want store this inforemation for future usage? ([Y]es, [N]o)
~~~
As you can see, after gathering information script asks you if you condiser to save your data or not. If you agree with that, it will store your data in `.profile_git` file. Now the script will do rest of works for you as it [mentioned before](https://github.com/PS-Professional/Organization-Backup#what-is-this-project?)