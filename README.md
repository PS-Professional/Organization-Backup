<h1 align="center"><b>Organization rpo backup</b></h1>

### What is this project?

This project will clone and craete a backup from your organization repositories. First The `repo-backup.sh` script makes a request to GitHub API and gets data about projects using your credits. Then, it will search through requested data and uses `ssh_url` variable to clone them into `./tmp` directory using SSH. Then, it will start to archive and compress (using XZ) each project. After that, once more, the script archives and compresses projects into a single file. After completing the previous steps, the script will removees last level files to keep your storage fresh and free. The final file name would be `GitHubRepos([day][month-abbrviation][year]).tar.xz`

### Requirements of this project

Before using this project, make sure your GitHub account meet these requirements . First, You need to know this project uses SSH connections to clone projects, so check [your account SSH configurations](https://github.com/settings/keys) if you added your SSH public key to your account and it is valid. After that, you need to create a personal access token, to access to GitHub API by that. If you don't have any access token, you can create one from [GitHub account settings](https://github.com/settings/tokens). Note that your access token only need `read:org` permission from `admin:org` section. With these two options available on your account, you can create a backup file from your desired repositories.

###  How to use the script?

To run the script, use this command:

```bash
./repo-backup.sh
```

By running the script for the first time, you will be asked to enter you your GitHub username, organization name (Bear in mind that both are case sensitive!) and your personal access token. Now, Let's take a look at following example:

```bash
$ ./repo-backup.sh
Welcome to Organization Backup scrpit!
Developed by PS-Professional
Let's start! :)
This script need your information to perform backup task
Please enter your GitHub username: My_user
Please enter your GitHub organization name: My_Organization
Please enter your GitHub token : My_Personal_Access_Token
Do you want store this information for future usage? ([Y]es, [N]o)
```

As you can see, after gathering the required information, the script asks you if you want your data to be saved or not. If you want so, the script stores your data in `.profile_git` file. By this moment,  the script is going to do the rest for you, just as [mentioned before](https://github.com/PS-Professional/Organization-Backup#what-is-this-project).
