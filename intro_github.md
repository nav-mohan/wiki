# Introduction to Git & Github

## Requirements
### Sign-up on Github
- Sign-up for a free account on [Github](https://github.com).

### Install git
- Install git on your local machine by following instructions specific to your operating-system [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Configure some of the global settings for your local installation of git.
    ```sh
    git config --global user.name "myusername"      # username
    git config --global user.email "abc@xyz.com"    # email-id
    git config --global core.editor "nano"          # default text-editor
    git config --global init.defaultBranch "main"   # default branch name
    ```
- You could use the same username and email-id as your Github account. \
`"main"` is a fairly common default branch name across the world. We will cover *branches* in a later section. \
The text-editor will come in handy when we want to *modify commit history* of our project. We will cover this in a later section. You could use a different text-editor if you wish (such as `"vim"` or `"emacs"`).

> The `user.name` and `user.email` are not *authentication* parameters. They are merely used to identify who contributed what. We will cover authentication in a later section.

### Install VS-Code extension
- Install a VS-Code extension for Git. GitLens is a popular one. 
    <img src = "gitlens-extension.png" style="width:640px">

## Git & Github
Git is a distributed version control system used to track changes in source code during software development. It allows multiple developers to collaborate on a project efficiently by managing code history, *branching*, and *merging*. 

GitHub is a *web-based platform* built around Git that provides a user-friendly interface for hosting and sharing Git repositories. It offers collaboration tools such as *issue tracking*, *pull requests*, and discussion boards thus, making it a central hub for open-source projects.

### Version-Control
Version control means keeping track of creating and modifying source code. It's a bit like the "track changes" function in MS Word, but far more efficient and better at resolving conflicts when two or more people are working on the same document. Many people keep track of different versions of a document by saving multiple copies and appending notes like "version 3" to their filename. This is inefficient for several reasons:
- there is a lot of redundancy
- the amount of space taken up in your filesystem grows linearly with the number of versions
- it is not transparent - there is no guarantee of a consistent naming scheme to indicate versions
- it is fragile - if the filename is changed, or if someone opens the file and makes and saves a trivial edit, then the document modification date no longer corresponds to its relative position in the versioning history
- there is no framework for resolving conflicting changes by multiple authors
Version (or "revision") control systems (VCSs) were developed to address these problems in the context of collaborative software development. Currently, one of the most popular VCSs is git.

> Git can only track text-based files (`.txt`, `.py`, `.cpp`, `.f90`, etc). \
Git cannot meaningfully track binary format files (`.pdf`, `.jpeg`, etc.)\
If you wish to selectively ignore tracking certain files (such as reference notes and scratch-pads) create a `.gitignore` file in the root of your repository and list the filenames and foldernames to be ignored. For example 
```sh
#.gitignore
scratch.txt # a specific file
build/ # the entire build/ folder
refs/*.txt # regex to specify all .txt files within the refs/ folder
``` 

### Commits
- A commit in Git is a snapshot of your project at a specific point in time. Each commit is made up of 5 properties:
    - The changes to the code-base (also called *diff*)
    - a descriptive message about the changes
    - the author of the contribution
    - the timestamp of the contribution
    - the `commit-hash`, a 40 character hexadecimal SHA-1 checksum computed from the above 4 properties.

    <img src = "./commit.png" style="width:480px">

- The `commit-hash` is useful when comparing the state of the project at two different times.
### Staging
- *Staging* is a pre-cursor step to committing. A commit might involve changes across multiple files. We first gather all such changes before collectively committing them.

### Branching
- *Branches* are a powerful feature of Git. It allows you to create an independant line of development without affecting the main codebase.

    <img src ="branching.png" style="background-color:black;width:640px">

- In the diagram above, there are 5 branches
    - The `main` branch contains the most stable version of your codebase. It is ready to be deployed and distributed to end-users. 
    - When a bug was discovered in `main`, a new branch `bugfix` was created from the latest `main` branch. Commits `B1`, `B2` were the necessary changes to fix the bug. 
    - While the bug was being addressed, your collaborator pushed a minor change directly into `main`. This is generally discouraged but it is acceptable for minor issues or emergency hotfixes.
    - While the bug was addressed, your collaborator branched out from `main` to implement a new feature. The commits `F1`,`F2`,`F3` were the necessary changes for this new feature. 
    - While your collaborator was implementing the new feature, you completed the bugfix and merged your `bugfix` branch into the `main` branch. This results in a *merge-commit* due to the *non-linear history* of `bugfix` and `main` (The commit `M2` does not exist in the `bugfix` branch). 
    - After fixing the bug you discovered an opportunity to reduce code-duplication so you immediately branch `refactor_branch` from `main`. The `refactor_branch` contains your contributions from `bugfix_branch`. 
    - While you were working on the code-refactoring, your collaborator completed the feature implementation and merged their changes into `main`. They immediately start updating the documentation for this new feature. The `documentation_branch` is merged as a *fast-forward commit* because it has a *linear history* with `main`. 
    - Finally, you finished your work on refactoring the code and merged your `refactor_branch` into `main`.

- The `bugfix_branch`, `refactor_branch`, `feature_branch`, and `documentation_branch` are commonly called *topic-branches*. If topic-branches modify common codespace, Git will alert us of a *merge-conflict* when we attempt to merge the topic-branch into `main`. We will address this in a later section. 

### Issue-Tracking
We make extensive use of GitHub's issue tracking system to manage projects in the lab.  Generally, we create a new repository for each project, and each repository has its own issue tracker.  Using the issue tracker, we do the following:

1. Plan tasks and project milestones by creating an issue for each task that needs to be accomplished, and by organizing these issues into milestones with set deadlines.
2. Create issues when a problem arises.  If you don't know how to do something, or if your code has a bug that you can't fix, then write an issue.  If it's a bug, describe the problem and identify the affected source code and the scenario that causes the bug to arise.  Other people in the group will be able to see the issue and help you fix the problem.  This is also valuable for documenting how your bug was resolved.  When the bug is fixed, close the issue either using the web interface or by committing the bug fix with the comment "fixed #27" if the issue is number #27.  Read [this GitHub manual](https://help.github.com/articles/closing-issues-via-commit-messages/) for more information.
3. If you simply have a question, post an issue.  The issue tracker can then serve as a discussion forum with other members of the lab.

    <img src = "./issues.png" style="width:480px">


## Demo (offline)
### Create a repo
- Create a new repo on your local machine
    ```sh
    git init demo_repo;   # initialize a new repo folder
    cd demo_repo;         # navigate to repo folder
    git status;             # check status of repo
    ```
    <img src = "./demo-offline/init.png" style="width:480px">

### Staging, Commiting
- Create a new file in the repo
    ```sh
    touch notes.txt;        # create new file
    git status;             # check status of repo
    ```
    <img src = "./demo-offline/newfile.png" style="width:480px">
- We created a new file `notes.txt` Git is not currently _tracking_ it's history. We need to tell Git to start tracking it. Commiting this change (create new file) will prompt Git to track it.

    ```sh
    git add notes.txt;  # stage the change
    git status;         # check status of repo
    ```

    <img src = "./demo-offline/staging.png" style="width:360px">

    ```sh
    git commit -m "create new file";    # commit the change
    git log;                            # check history
    ```
    <img src = "./demo-offline/commit-1.png" style="width:480px">
    
    The 40-character alphanumeric string <span style = "color:rgb(213, 186, 30);background-color:black">9a77d0... </span> is the `commit-id`

- Add some text to `notes.txt`.
    ```sh
    echo "Hello World" > notes.txt;         # append text
    git status;                             # check status
    ```
    <img src = "./demo-offline/commit-2.png" style="width:480px">
    
    and commit the change
    ```sh
    git add notes.txt;                      # stage
    git commit -m "append 'Hello World'";   # commit
    git log;                                # check history
    ```
    <img src = "./demo-offline/commit-3.png" style="width:480px">
    
    > Notice the <span style = "color:rgb(30, 182, 213);background-color:black;font-weight:600">HEAD -></span> <span style = "color:rgb(61, 213, 30);background-color:black;font-weight:600"> main </span>. Git stores commits as a [**linked-list**](https://en.wikipedia.org/wiki/Linked_list) and `HEAD` is the current pointer of the linked-list. Currently, our `HEAD` sits at the latest commit <span style = "color:rgb(213, 186, 30);background-color:black">a27700... </span> of the `main` branch. We will learn more about the `HEAD` in the section about rewinding/rebasing but for now just remember that Git stores commits as a linked-list. 

### Branching and Merging
- So far, we were directly pushing changes into the `main` branch. This is rarely the case when working on a shared codespace. Let's append another line but this time let's do it through a branch.
- Create a new branch
    ```sh
    git branch feature/append-new-line; # create new branch
    git branch -lva;                    # list all branches
    ```
    <img src = "./demo-offline/branch-1.png" style="width:480px">

    `-lva` flag lists all branches and their latest commits. We're currently on the `main` branch and `feature/append-new-line` has the same commit history as `main`.
- To begin working from this new branch, first `checkout` the branch
    ```sh
    git checkout feature/append-new-line; 
    git status;
    git log;
    ```
    <img src = "./demo-offline/branch-2.png" style="width:480px">

    > Notice the <span style = "color:rgb(30, 182, 213);background-color:black;font-weight:600">HEAD -></span> <span style = "color:rgb(61, 213, 30);background-color:black;font-weight:600"> feature/append-new-line, main </span>. Currently, our `HEAD` sits at the latest commit <span style = "color:rgb(213, 186, 30);background-color:black">a27700... </span> of the `feature/append-new-line` branch which is also the latest  commit on the `main` branch.

- And now repeat the same steps as we did in `main` - make edits, stage the change, and commit the change. 
    ```sh
    echo "Lorem Ipsum" >> notes.txt;
    git add notes.txt;
    git commit -m "append Lorem Ipsum";
    git log --oneline;
    ```
    <img src = "./demo-offline/branch-3.png" style="width:480px">

- We've successfully modified our `feature/append-new-line` branch. To incorporate this change into our `main` branch, we perform a *merge operation* from `feature/append-new-line` into `main`. 
    ```sh
    git checkout main;
    git diff feature/append-new-line; # show difference between branches
    ```
    <img src = "./demo-offline/branch-4.png" style="width:480px">
- Perform the `merge` operation
    ```sh
    git merge feature/append-new-line;
    git log --oneline;
    ```
    <img src = "./demo-offline/branch-5.png" style="width:480px">
    
    Observe that Git does a *Fast-forward* merge. This happens because no new commits were pushed/merged into `main` before we merged `feature/append-new-line`. The two branches are said to have a *linear history*.
    
    > <img src = "./demo-offline/non-linear-history.drawio.svg" style="width:480px;background-color:black">
    >
    > In the above diagram, `bugfix` branch has a *linear* history with `main` whereas `feature` branch has a *non-linear* history with `main`. A fast-forward merge merely involves updating the next-pointers on the linked-list. So `M1`'s next-pointer is directed at `B1`.

- We've finished merging our topic branch `feature/append-new-line` into `main` hence, we can delete the topic branch by executing `git branch -d feature/append-new-line`. 

## Merge-Conflict (offline)
- When two or more collaborators work on a shared codespace, you are likely to encounter a *merge-conflict*. Let's pick-up where we left off last time and recreate a merge-conflict between two topic branches. We'll also start using Visual Studio Code for managing our Git repository so open your `demo_repo/` folder in VS-Code.

    <table style="width:720px;border:1px solid rgb(128, 128, 128)">
    <tr>
        <th style="border:1px solid  rgb(128, 128, 128)">Open Folder in VS-Code</th>
        <th style="border:1px solid  rgb(128, 128, 128)">Source-Control in VS-Code</th>
    </tr>
    <tr>
        <td style="border:1px solid  rgb(128, 128, 128)"><img src = "./merge-conflict-offline/vscode-1.png" style="width:360px"></td>
        <td style="border:1px solid  rgb(128, 128, 128)"><img src = "./merge-conflict-offline/vscode-2.png" style="width:360px"></td>
      </tr>
    </table>


- Create two new topic branches `refactor/swap-lines` and `feature/append-line`. 
    ```sh
    git branch refactor/swap-lines;
    git branch feature/append-line;
    git branch -va; # confirm all 3 branches have same commit history
    ```
    <img src = "./merge-conflict-offline/branch-1.png" style="width:480px">

- Checkout the `refactor/swap-lines` branch (`git checkout refactor/swap-lines`) and swap the first two lines of `notes.txt`. Then stage and commit the change.

    <img src = "./merge-conflict-offline/refactor.gif" style="width:720px">

- Checkout the `feature/append-line` branch (`git checkout feature/append-line`) and add a line to `notes.txt`. Then stage and commit the change.

    <img src = "./merge-conflict-offline/feature.gif" style="width:720px">

    > The two branches `refactor/swap-lines` and `feature/append-line` are said to *diverge*. 

- First merge `refactor/swap-lines` into `main`. 
    ```sh
    git checkout main;
    git merge refactor/swap-lines;
    git log --oneline;
    ```
    
    <img src = "./merge-conflict-offline/merge-1.png" style="width:480px">


- Now merge `feature/append-line` into `main`. 
    ```sh
    git checkout main;
    git merge feature/append-line;
    ```

    <img src = "./merge-conflict-offline/merge-2.png" style="width:480px">

    Git will alert us of a *merge-conflict* because the changes from `refactor/swap-lines` and `feature/append-line` modify the same code-space and it's not immediately apparent to Git how to combine those changes. There are a few different possible combinations. 
    
<table border="1" cellpadding="10" style="margin:auto">
<tr>
<th>feature branch</th>
<th>main, refactor</th>
</tr>
<tr>
<td><pre style="background-color: rgb(150,150,150); font-family: monospace; color:black">
Hello World
Lorem Ipsum
New Feature
</pre></td>
<td><pre style="background-color: rgb(150,150,150); font-family: monospace; color:black">
Lorem Ipsum
Hello World
</pre></td>
</tr>
</table>

<table border="1" cellpadding="10" style="margin:10px auto">
<tr>
<th>❌ feature duplicates <br> main content</th>
<th>❌ feature partially <br>overwrites refactor</th>
<th> ✅ feature appends <br> to refactor</th>
</tr>
<tr>
<td><pre style="background-color: rgb(150,150,150); font-family: monospace; color:black">
Lorem Ipsum
Hello World
Lorem Ipsum
New Feature
</pre></td>
<td><pre style="background-color: rgb(150,150,150); font-family: monospace; color:black">
Lorem Ipsum
New Feature
</pre></td>
<td><pre style="background-color: rgb(150,150,150); font-family: monospace; color:black">
Lorem Ipsum
Hello World
New Feature
</pre></td>
</tr>
</table>

- We need to manually resolve this merge-conflict using VS-Code. Open the `notes.txt` file in the Source-Control Tab and click <button style="color:white;background-color:rgb(12, 125, 224);padding:5px;border-radius:5px">Resolve in Merge Editor</button> at the bottom right.
    
    <img src = "./merge-conflict-offline/merge-3.png" style="width:640px">
- This opens the VS-Code Merge-Editor UI. As the name suggests, it enables you to apply changes before merging. The *Incoming* left panel shows the changes from `feature/append-line`. The *Current* right panel shows state of the `main` branch. The *Result* bottom panel previews the result of the merge operation your editing. 

    <img src = "./merge-conflict-offline/merge-4.png" style="width:640px">

- There are a few different options - `Accept Incoming`, `Accept Current`, `Accept Combination`.
    - ❌ `Accept Current` : This ignores all changes from the `feature/append-line` branch. Clearly this is not what we want.

        <img src = "./merge-conflict-offline/accept-current.gif" style="width:640px">

    - ❌ `Accept Incoming` : On the `feature` branch **"Hello World"** is followed by **"Lorem Ipsum"** and **"New Feature"**. On the `main` branch, `Hello World` is the last line. So Git merely tacks on **"Lorem Ipsum"** and **"New Feature"** to the end of the `main` branch.

        <img src = "./merge-conflict-offline/accept-incoming.gif" style="width:640px">
    
    - ✅ `Accept Combination` : This correctly appends **"New Feature"** to the end of the file without affecting the  prior two lines. 
        <img src = "./merge-conflict-offline/accept-combination.gif" style="width:640px">

    - ✅ `Manual Resolution` : When the merge conflict only concerns a few lines you could directly edit the content in the *Result panel* 
        <img src = "./merge-conflict-offline/manual-resolution.gif" style="width:640px">

- After the merge-conflict is resolved, there is an additional *merge commit* to the `main` branch. You may edit the commit message if you choose to but the default commit message `"Merge branch <branch-name>"` is recommended. 

    <img src = "./merge-conflict-offline/merge-commit.png" style="width:480px">

## Demo (online)
- So far our work has been on our local machine. To collaborate with other developers we must setup a remote repository on Github and *track* it from our local repository. 
### Github Authentication
- Before we setup the remote repository, any collaboration on the cloud must involve secure authentication. Github provides a few options for this.
- SSH Keys
    - This is the easiest and recommended method. If you haven't already, generate your private-public ssh-keys. Then copy the contents of the public key (`.pub`) and paste it into 
    - Navigate to your __Github Profile Settings__ and under the __Access Settings__, click on __SSH and GPG keys__. Then add a new SSH key. Give it a unique title and paste the contents of your `.pub` file into the textbox. 
    - Once you've registered your SSH key, it becomes straightforward to access your repos  
        - `git clone git@github.com:nav-mohan/kim-api.git`
        - `git remote add origin git@github.com:nav-mohan/kim-api.git`

- Github Auth Tokens
    - Github Auth Tokens allow for a more granular access control and are typically used to perform advanced operations using the Github API (such as automation & CI/CD) but, they can also be used for performing regular git repo operations such as contributing code. 
    - To generate your Auth Tokens navigate to your __Github Profile Settings__, and click on __Developer Settings__.  Then under __Personal Access Tokens__ click on __Fine-grained tokens__ or __Tokens (classic)__. 
    - Both types of tokens have a different UI for configuring the access control restrictions of the token. You should be familiar with  
    <!-- - <img src = "./auth-token-setting.png" style="width:320px"> -->
    - Once you've generated your access-token you need to specify it when managing repos
        - `git clone https:// [TOKEN]@github.com/[USER]/[REP0]`
        - `git remote add origin https://[TOKEN]@github.com/[USER]/[REP0] `
- Open up specific repos for collaborations
    - You can also open up a specific repo to contributions from a specific user. 
    - Navigate to your repo's __Settings__ and under __Access__ click on __Collaborations__. Now specify the users you wish to authorize to contribute directly into your repo. 
    
### Creating a repo
### Forking from original
### Connecting your local-machine to your fork
### Pushing to your Fork
### opening a PR from your fork to original

## Merge-Conflict (online)
- first resolve the merge-conflict on your *local* machine 
- if you are pushing to a fork, then first sync your forked repo with the upstream
- update your *local* `main` branch first and then merge `main` into `work_branch`
- the direction of this merge is the opposite of what you would usually do
- by merging `main` into `work_branch` you are "updating" your *local* `work_branch` first
- now resolve the merge-conflict *locally*, the same way as before.
- once `main` has been incorporated into *local* `work_branch`, push your changes to your *remote* `work_branch`.

## Rewinding the `HEAD`
- Notice the <span style = "color:rgb(30, 182, 213);background-color:black;font-weight:600">HEAD -></span> <span style = "color:rgb(61, 213, 30);background-color:black;font-weight:600"> main </span>. Git stores commits as a [**linked-list**](https://en.wikipedia.org/wiki/Linked_list) and `HEAD` is the current pointer of the linked-list. Currently, our `HEAD` sits at the latest commit <span style = "color:rgb(213, 186, 30);background-color:black">e4fbe... </span> of the `main` branch. 
- Modifying the position of the `HEAD` can be useful when hunting for the source of a bug, for example: 
    ```sh
    git checkout e1f518;    # rewind head to this commit
    ```
- Now build your code (if required), test it, and confirm the presence/absence of the bug at this point in history. When satisfied you can reset your `HEAD` back to the latest commit
    ```sh
    git switch -;           # return HEAD back to latest commit
    ```
- You could also rewind to a past commit, create a new branch, and start working from a previous point in history. This is useful when addressing emergency hot-fixes.
    ```
    git checkout <commit-hash>;
    git branch bugfix/issue#95-fix-regression-in-parameter-files;
    git checkout bugfix/issue#95-fix-regression-in-parameter-files;
    ```
    Once you've addressed the bugfix, you should do a *force-push* to the remote. We will dive deeper into force-push in the section about *rebasing* but essentially force-push overwrites the commit-history from the last common ancestor onwards, which in this case would be `<commit-hash>`.

## Undo Changes (offline simple, online force-push)
- `git reset` is a powerful Git command to **undo changes**. 



## Rebasing & Modifying History
### Rebasing
### Force-Push

## Rebase Exercise from Weston's QPS Git problem

## Best Practices
- **Write issues!**. This is a tremendously useful feature. 
- At the end of the day, commit your work to your *local* repo and push changes to GitHub.
- *Stash* your changes if they're not ready for a commit. For example `git stash -m "work-in-progress split large files"`. 
- when working on the [kim-api repository](https://github.com/openkim/kim-api/) remember to branch out from the `devel` branch rather than the `main` branch. 
- If possible remember to clean-up the commit-history, squash commits to reduce log history, rename commits to improve readability. 
- Avoid using special characters in branch names.`#`, `-`, `_`, and `/` are acceptable and even encouraged. Whitespaces should be avoided.
- Organize the branch names, and specify *issue-numbers*, for example:
    - `bugfix/issue#84-gcc12-linking-issue`
    - `hotfix/issue#95-fix-regression-param-files`
    - `feature/issue#66-openmp-support-for-kimapi`
    - `doc/issue#88-expected-tmp-dir-permissions`
    - `refactor/issue#68-reduce-overhead-process_d_term-routines`
    - `devops/issue#99-github-actions-for-macos`

    Categorically organizing branches as `bugfix/`, `hotfix/`, etc will make it easier to find relevant branches and execute (or skip) automated-tests on special branches. Specifying the `issue#` will prompt Github to automatically link your pull-requests with the relevant issue.
    

## Cheat Sheet
- git status, git log, git log --oneline
- git cherry-pick commit_hash
- git restore /path/to/file, git restore /path/to/folder
- git restore --staged /path/to/file, git restore --staged /path/to/folder
- git reset --soft commit_hash, git reset --soft HEAD~N # move head to commit_hash, N-commits back 
- git reset --hard commit_hash, git reset --hard HEAD~N # move head to commit_hash, N-commits back 
- git clone link, git submodule --recursive link
    - To get the latest development state:
    - git clone --recursive link
    - If your git version does not support -- recursive clones, do
    - git clone https://gitlab.xiph.org/xiph/icecast-server.git
    - cd icecast-server
    - git submodule update --init
    - git submodule add --force <https://github.com/url/of/submodule> lib/your_preferred_directory-name_for_submodule
    - this will create a new folder <your_preferred_directory-name_for_submodule> within the lib directory
    - some of the folders within this new folder might appear to be empty. that's probably because the submodule depends on further submodule. We need to initialize and update the submodule to bring in all the subsubmodules
    cd lib/your_preferred_directory-name_for_submodule
    git submodule init
    git submodule update

## Bonus - github.io static webpage