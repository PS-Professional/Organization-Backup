Organization repository backup script

Developed by PS-Professional

     ____  ____        ____             __               _                   _
    |  _ \/ ___|      |  _ \ _ __ ___  / _| ___  ___ ___(_) ___  _ __   __ _| |
    | |_) \___ \ _____| |_) | '__/ _ \| |_ / _ \/ __/ __| |/ _ \| '_ \ / _` | |
    |  __/ ___) |_____|  __/| | | (_) |  _|  __/\__ \__ \ | (_) | | | | (_| | |
    |_|   |____/      |_|   |_|  \___/|_|  \___||___/___/_|\___/|_| |_|\__,_|_|

## What is this project?

This project will clone and craete backup from your organization repositories. First The `repo-backup.sh` script makes a request to Github API and gets data about projects using your credits. Then, it will search through requested data and uses `ssh_url` variable to clone them into `./tmp` directory using SSH. Then, it will start archive and compress (using XZ) each project. After that, it will again archive and compress projects into a single file. After completing the previous steps, the script will remove last level files to keep your storage clean and free. The final file name would be `GithubRepos([day][month-abbrviation][year]).tar.xz`

## Requirements of this project

Before using this project, make sure your GitHub account meet these requirements . First, this project uses SSH conections to clone projects, so check [your account SSH configurations](https://github.com/settings/keys) if it is available and valid. After that, you need to create a personal access token, to access to Github API using it. If you don't have any access token, you can create it from [Github account settings](https://github.com/settings/tokens). Note that your access token only need `read:org` permission from `admin:org` section. With these two options available on your account, you can create a backup file from your desired repositories.

##  How to use the script?

To run the script, use this command:
```
./repo-backup.sh
```
By running the script for the first time, you will be asked to enter you your Github username, organization name (Note that both are case sensitive!) and your personal access token. Let's take a look at following example:
~~~
╭─parsa@PS-Pro ~/Organization-Backup
╰─$ ./repo-backup.sh
Welcome to Organization Backup scrpit!
Developed by PS-Professional
Let's start! :)
This script need your information to perform backup task
Please enter your Github username: My_user
Please enter your Github organization name: My_Organization
Please enter your Github token : My_Personal_Access_Token
Do you want store this inforemation for future usage? ([Y]es, [N]o)
~~~
As you can see, after gathering the required information, script asks you if you want your data to be saved or not. If you want so, the script stores your data in `.profile_git` file. Now the script si going to do the rest for you as it was [mentioned before](https://github.com/PS-Professional/Organization-Backup#what-is-this-project).