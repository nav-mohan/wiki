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
    
    > <img src = "./demo-offline/non-linear-history.drawio.png" style="width:480px;background-color:black">
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
- <b> SSH Keys </b>
    - This is the easiest and recommended method. If you haven't already, generate your private-public ssh-keys. Then copy the contents of the public key (`.pub`) into your clipboard. 
    - Navigate to your __Github Profile Settings__ and under the __Access Settings__, click on __SSH and GPG keys__. Then add a new SSH key. Give it a unique title and paste the contents of your `.pub` file into the textbox. 
        <div style = "display:flex; align-items:center; justify-content:center;" >
        <img src = "./auth/profile-settings.png" style="width:320px; margin: 5px; flex-basis:30%;">
        <img src = "./auth/ssh-keys-1.png" style="width:320px; margin: 5px; flex-basis:30%;">
        <img src = "./auth/ssh-keys-2.png" style="width:320px; margin: 5px; flex-basis:30%;">
        <div>

    - Once you've registered your SSH key, it becomes straightforward to access your repos  
        ```sh
        # clone a remote repo into your local machine
        git clone git@github.com:[USER]/[REPO]
        
        # connect your existing local repo with a specific remote repo
        cd /path/to/local/repo;     # navigate to the local repo
        git remote remove origin    # remove any existing remotes called "origin" 
        git remote add origin git@github.com:[USER]/[REPO];
        ```
- <b> Github Auth Tokens </b>
    - Github Auth Tokens allow for a more granular access control and are typically used to perform advanced operations using the Github API (such as automation & CI/CD) but, they can also be used for performing regular git repo operations such as contributing code. 
    - To generate your Auth Tokens navigate to your __Github Profile Settings__, and click on __Developer Settings__.  Then under __Personal Access Tokens__ click on __Fine-grained tokens__ or __Tokens (classic)__. 
    - Both types of tokens have slightly different UIs for configuring the access control restrictions of the token. For most situations, just ensure that you have the `read from repo` and `write to repo` permissions enabled for your token. 
    - <img src = "./auth/auth-token-setting.png" style="width:320px">
    - Once you've generated your access-token you need to specify it when managing repos
        ```sh
        git clone https://[TOKEN]@github.com/[USER]/[REP0]
        git remote add origin https://[TOKEN]@github.com/[USER]/[REP0] 
        ```
    > NOTE: On Hydra you might have to use Tokens because Hydra blocks SSH connections to Github but permits HTTPS connections.

- <b> Open up specific repos for collaborations </b>
    - You can also open up a specific repo to contributions from a specific user. 
    - Navigate to your repo's __Settings__ and under __Access__ click on __Collaborations__. Now specify the users you wish to authorize to contribute directly into your repo. 
        
        <div style = "display:flex; flex-direction:row; align-items:center" >
        <img src = "./auth/collab-1.png" style="flex-basis:50%; width:320px; margin:5px">
        <img src = "./auth/collab-2.png" style="flex-basis:50%; width:320px; margin:5px">
        </div>

### Creating a new repo on Github
- To Create a new repo click on the <button style="background-color:green;color:white;padding:5px; border-radius:5px;border:0; font-size:large">New</button> button on your Github homepage and enter the required fields on the subsequent input form.

    <img src = "./demo-online/new-repo.png" style="width:640px">

### Forking from original
- Instead of creating a new repo, if you wish to  copy an existing repo into your Github account, click on the <button style="background-color:white;color:black;padding:2px 5px;border-radius:5px; border:1px solid black; font-size: large">Fork</button> button at the top right of the repo. 

    <img src = "./demo-online/fork.png" style="width:640px">
  

> From hereon we will assume that we are dealing with a fork because that is the more realistic and interesting scenario. 
>    - `upstream` refers to the _original Github repo_ that you forked from. For example `openkim/kim-api`. 
>    - `origin` refers to _your fork_ of the original Github repo. For example `nav-mohan/kim-api`
>    - `local` refers to the Git repo on your local machine.

### Connecting your `local` Git repo to your `origin` Github repo
- Once your `origin` repo is established, you need to either create a new repo on your local machine or connect an existing local repo to the remote repo. 
- To create a new repo on your local machine execute
    ```sh
    # if you used ssh-keys for authenticating
    git clone git@github.com:[USERNAME]/[REPO]

    # if you used Github tokens for authenticating 
    git clone https://[TOKEN]@github.com/[USERNAME]/[REP0]
    ```
- To connect an existing local repo to your `origin` repo, navigate to the repo directory on your local machine and execute 
    ```sh
    # if you used ssh-keys for authenticating
    git remote add origin git@github.com:[USERNAME]/[REPO]

    # if you used Github tokens for authenticating 
    git remote add origin https://[TOKEN]@github.com/[USERNAME]/[REP0]
    ```
    > Here, `origin` is the name used by your local repo to refer to the remote repo. You could name it anything else if you wish but `origin` is a standard name. If you're working with an existing repo, there might already exist a `remote` connection called `origin`. In that case execute `git remote remove origin;` to remove the connection or call your new remote connection by a different name. 
- You may connect your `local` git repo to multiple Github repos. This will be necessary when resolving merge-conflicts between `origin` and `upstream`. For example, lets say username Bob was the original creator of a Github repo `demo_repo` and username Alice has forked Bob's Github repo into her own repo. In this case, Alice would connect her local repo to her Github fork as well as Bob's Github repo. 
    ```sh
    # connect to demo_repo fork of Alice 
    git remote add origin git@github.com:alice/demo_repo;

    # connect to original demo_repo repo of Bob
    git remote add upstream git@github.com:bob/demo_repo;
    ```
    <img src = "./demo-online/upstream-origin-local.png" style="width:640px">

    > NOTE: You could `clone` the `upstream` into you `local` if you merely wish to test out a repo. However, if you plan on contributing to `upstream` then you shouldn't clone `upstream` but instead fork to an `origin` and then clone the `origin`. 

- To list all the remote repos that your `local` repo is connected to, execute `git remote --verbose`

    <img src = "./demo-online/remotes.png" style="width:480px">
    

### Pushing changes to your remote repo
- Make some edits to the files in your `local` repo, stage the changes, and commit them. 
- Push the changes to the `origin` repo by executing 
    ```sh
    git push origin
    ```

### Pull-Requests: Contributing changes from your fork `origin` to the `upstream`
- If your `origin` repo was forked from an `upstream` and you wish to contribute your changes from your `origin` repo to the `upstream`, you can do so by opening a _pull request_. 

- Click on the <button style="background-color:white;color:black;padding:2px 5px;border-radius:5px; border:1px solid black; font-size: large">Contribute</button> button and click on <button style = "background-color:green; color:white; padding:2px 10px; border:none; border-radius:4px; font-size:large"> Open pull Request </button> button

    <img src = "./demo-online/contribute.png" style="width:480px">

- On the subsequent page you can set the source and target of the pull-request.

    <img src = "./demo-online/pull-request.png" style="width:480px">


### Synchronize your fork with original
- If the `upstream` of your fork has had changes and you wish to update your `origin` then click on <button style="background-color:white; color:black; padding:5px 10px; border:none; border-radius:5px; font-size:large"> Sync fork </button> button. 
    
    <img src = "./demo-online/sync.png" style="width:480px">

- Once your `origin` repo has been synchronized with the `upstream`, you need to synchronize your `local` repo with your `origin` repo by executing
    ```sh
    git fetch origin/topic_branch;
    git merge origin/topic_branch;

    # git pull combines git fetch and git merge
    git pull origin/topic_branch;
    ```
- `git fetch` downloads new data (like commits, branches, and tags) from the `origin` repository, but it does not modify your working directory or current branch.
- `git merge` merges the changes from the remote repo into the current branch on your `local` repo.
- `git pull` calls both `git fetch` and `git merge`. 
- If you want to preview changes before merging, use `git fetch` followed by `git diff`.

    <img src = "./demo-online/pull-sync.png" style="width:640px">

    > NOTE: It's generally not a good idea to `pull` directly from `upstream` into `local` unless you're merely testing out a repo. If you plan to contribute to `upstream` then always remember to update your `origin` first before updating your `local`.


## Merge-Conflict (online)
- Resolving an online merge-conflict is very similar to the previously explored offline merge-conflict but there are some extra steps. 
- Online merge-conflicts usually arise when you're attempting to merge a pull-request from your `origin` to the `upstream`. 
    > There is also the merge-conflict that arises within a single repo when merging a `topic_branch` into `main` branch. But, this case is identical to the offline merge-conflict we saw earlier.  

- Suppose you're working on `local/topic_branch` and you wish to contribute your changes to `upstream/main` via your fork at `origin/topic_branch`. The usual workflow would involve pushing changes from `local/topic_branch` into `origin/topic_branch` and then opening a pull-request from `origin/topic_branch` into `upstream/main`. However, there is a merge-conflict between `origin/topic_branch` and `upstream/main`. 
- To resolve this, first you must resolve the merge-confict on your `local` repo. 
- If you haven't already, add the `upstream` to your `local` repo's list of remotes.
    ```sh
    git remote add upstream <URL>
    ```
- Now merge the `upstream/main` directly into your `local/topic_branch` repo. By merging `upstream/main` into `local/topic_branch` you are updating your `local/topic_branch` first. 
    ```sh
    git fetch upstream;         # get latest upstream
    git merge upstream/main;    # merge upstream/main -> local/topic_branch
    ```
    > NOTE: The direction of this merge is the opposite of what you would usually do. Typically we merge from `topic-branch` into `main` but in this case we are merging from `main` into `topic-branch` 

- Git will alert you to the merge-conflict and halt the merge operation midway. Now resolve the merge-conflict *locally*, by following the same steps as the offline scenario.
- Once `upstream/main` has been merged into `local/topic_branch` you may now push your `local/topic_branch` into your `origin/topic_branch`. Remember to use the `-f` flag for `force-push` because `local/topic_branch` and `origin/topic_branch` have _diverged_. 
    ```sh
    # use -f flag for force-push 
    git push -f origin
    ```

- Resolving the merge-conflict by merging `main` into `topic-branch` will create a new _merge-commmit_. If you wish to avoid that and maintain a _linear commit history_ then you should use `git rebase`. We will discuss this in the next section.  

## Exploring \& modifying the commit history
### Detaching the `HEAD` with `git checkout`
- Execute `git log` command on any repo. For example, here are the logs of the `devel` branch of the `kim-api` repo
    
    <img src = "./commit-history/linked-list.png" style="width:480px">

- Notice the <span style = "color:rgb(30, 182, 213);background-color:black;font-weight:600">HEAD -></span> <span style = "color:rgb(61, 213, 30);background-color:black;font-weight:600"> devel </span>. Git stores commits as a [**linked-list**](https://en.wikipedia.org/wiki/Linked_list) and `HEAD` is the current pointer of the linked-list. Currently, our `HEAD` sits at the latest commit <span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef </span> of the `devel` branch. 
- Modifying the position of the `HEAD` can be useful when hunting for the source of a bug. For example, if I wish to investigate whether commit <span style = "color:rgb(213, 186, 30);background-color:black">8c9a1099</span> introduced a bug, I could rewind to the commit prior that: 
    ```sh
    git checkout 04d886a1;    # rewind head to this commit
    ```
- Now test it (build the code first if required) to confirm the presence/absence of the bug at this point in history. When satisfied you can reset your `HEAD` back to the latest commit
    ```sh
    git switch -;           # return HEAD back to latest commit
    ```
- You could also rewind to a past commit, create a new branch, and start working from a previous point in history. This is useful when addressing emergency hot-fixes.
    ```sh
    git checkout <commit-hash>;     # the last commit where everything worked fine 
    git branch "bugfix/issue#95-fix-regression-in-parameter-files";     # create a new branch from this point 
    git switch -; # return the HEAD back to it's original position
    git checkout "bugfix/issue#95-fix-regression-in-parameter-files";   # checkout the new branch and start working 
    ```
    Once you've addressed the bugfix, you should do a *force-push* to the `origin`. We will dive deeper into force-push in the section about *rebasing* but essentially force-push overwrites the commit-history from the last common ancestor onwards, which in this case would be `<commit-hash>`.

    > Upon executing `git checkout <COMMIT-HASH>` Git will alert you "You are in _detached `HEAD`_ state."  

    <img src = "./commit-history/detached-head.png" style="width:480px">
    
    >   - The branch that you were on is unmodified but the `HEAD` of the linked-list has been detached and now points to `<COMMIT-HASH>`. 
    >   - Technically, you are not on _any branch_ because a branch is defined by the linked-list of commits terminating at the `HEAD`. 
    >   - When you're in _detached `HEAD`_ state, you cannot create new commits on the branch. If you want to create new commits you'll have to create a new branch, checkout to that branch and then create commits on that new branch.

### Undo Changes with `git reset`
- `git reset` is a powerful Git command to **undo changes**. It moves the `HEAD` to a previous commit in history.
    ```sh
    # to reset to a specific commit
    git reset <COMMIT-HASH>

    # to go back N commits
    git reset HEAD~N
    ```
- There are 3 types of `git reset`
    - `git reset --soft <COMMIT-HASH>` - This resets the `HEAD` to the `<COMMIT-HASH>` and all the reset changes (the changes between `<COMMIT-HASH>` and the latest commit) are _staged_ and the working directory is unchanged. 
    - `git reset --mixed <COMMIT-HASH>` - This resets the `HEAD` to the `<COMMIT-HASH>` and all the reset changes (the changes between `<COMMIT-HASH>` and the latest commit) are _unstaged_ and the working directory is unchanged.
    - `git reset --hard <COMMIT-HASH>` - This resets the `HEAD` to the `<COMMIT-HASH>` and all the reset changes (the changes between `<COMMIT-HASH>` and the latest commit) are deleted from the working directory. 
    
<table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse; text-align: center;">
  <thead>
    <tr>
      <th style="border: 1px solid #ccc;">Reset Type</th>
      <th style="border: 1px solid #ccc;">Branch Status</th>
      <th style="border: 1px solid #ccc;">Log History</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="border: 1px solid #ccc;">Unchanged</td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/original-status.png" width="480"></td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/original-log-10.png" width="480"></td>
    </tr>
    <tr>
      <td style="border: 1px solid #ccc;">Soft Reset</td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/soft-status.png" width="480"></td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/soft-log-8.png" width="480"></td>
    </tr>
    <tr>
      <td style="border: 1px solid #ccc;">Mixed Reset</td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/mixed-status.png" width="480"></td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/mixed-log-8.png" width="480"></td>
    </tr>
    <tr>
      <td style="border: 1px solid #ccc;">Hard Reset</td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/hard-status.png" width="480"></td>
      <td style="border: 1px solid #ccc;"><img src="./commit-history/resets/hard-log-8.png" width="480"></td>
    </tr>
  </tbody>
</table>



- `git reset <COMMIT-HASH>` is different from `git checkout <COMMIT-HASH>` because `reset` modifies the commit history, (`--hard` also modifies the code-base), and points the `HEAD` to the new tip. Whereas `checkout` leaves the branch and code-base unchanged but merely points the `HEAD` to a past commit.

### Rebasing your branch with `git rebase`
- `git rebase` is a versatile and powerful command for achieving a cleaner, linear commit-history. In this section we will explore some common use cases for `git rebase`. 
> NOTE: Rebasing essentially rewinds the branch to an earlier commit and then reapplies the commits with specfied modifications. This could result in conflicts in which case Git will halt the rebase process. Once you've resolved the conflict you can resume the rebase process by executing `git rebase --continue`. Or, if you wish to terminate the rebasing process and revert all the changes made by the rebasing process, execute `git rebase --abort`. 

> NOTE: Rebasing your `local` branch will always cause it to diverge from the `origin` branch because they now have completely different commit history. To update your `origin` branch, you need to __force push__ from your `local` by executing `git push -f origin`. 

- #### 1) Incorporate `upstream` into `local` before pushing:
    - Use `git rebase` to incorporate changes from `upstream` into `local` before pushing. By directly pulling in changes from `upstream` into `local` your `local` and `upstream` will have a linear history thus avoiding merge-commits at the time of merge. Consider the below branching diagram - `main` was branched off into `feature` (green) and `bugfix` (red). The `bugfix` branch was merged before `feature`. Now, merging `feature` into `main` results in a merge-commit `M4`. To avoid this, `feature` branch can incorporate the commits `B1` and `B2` to acheive a linear commit-history with `main` as shown in the bottom diagram. 

        <img src = "./commit-history/rebasing.png" style="width:640px">

    - The overall workflow would look something like:
       ```sh
       git branch feature;      # create the new branch
       git checkout feature;    # checkout the feature branch
       git commit F1;           # modify code base feature branch
       git commit F2;           # modify code base feature branch
       git commit F3;           # modify code base feature branch
       git checkout main;       # switch to main branch
       git pull;                # update the main branch
       git checkout feature;    # switch back to feature branch
       git rebase main;         # rebase feature on top of latest main
       ```

    - If `B1`, `B2` touched the same code-space as `F1`, `F2`, `F3` then this will likely result in a merge-conflict at the time of rebasing. Git will halt the rebase process and alert you to the merge-conflict. Once you've resolved the merge-conflict you may resume the rebasing process by executing
        ```sh
        git rebase --continue; # resume the rebase after resolving merge-conflict
        ```
    - The original commits `F1`, `F2`, and `F3` have now been replaced with new commits `F1*`, `F2*`, `F3*`. These commits may or may not contain the exact same _diff_  (depending on the changes from `B1`,`B2`) however they are treated as _entirely new commits_ with different commit hashes from before. 

- #### 2) To `drop` commits
    - `git rebase` can be used to drop commits. 
    - Example: Consider the `devel` branch of `kim-api` repo. 

        <img src = "./commit-history/drop-1.png" style="width:480px">
    - Suppose we want to drop the commit __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span> "Fix typo in NEWS"__
    - Begin by jotting down the commit-hash of the previous commit __<span style = "color:rgb(213, 186, 30);background-color:black">9ed96a89</span> "Bump version to v2.4.2"__ and execute 
    ```sh
    git rebase -i 9ed96a89; # the commit-hash of the commit prior to our commit of interest
    ```
    - This will open up our text-editor (Nano in this case) listing out all recent commits upto and including our commit of interest. Note that every commit has the prefix `pick`. 

        <img src = "./commit-history/drop-2.png" style="width:480px">

    - To drop the commit, modify the prefix `pick` to `drop`. 
    - All the commits with the prefix `pick` are the commits that we wish to keep unchanged. 
    - Save (`CTRL+O`) and Exit(`CTRL+X`) the text-editor. 
    - Check the commit history to confirm that the commit has been dropped 

        <img src = "./commit-history/drop-3.png" style="width:480px">

    - The `local` repo diverges from the `origin` repo because the `local` repo has 4 commits following __<span style = "color:rgb(213, 186, 30);background-color:black">9ed96a89</span> "Bump version to v2.4.2"__ whereas the `origin` repo has 5 commits. 

        <img src = "./commit-history/drop-4.png" style="width:480px">
    - To push your updated `local` branch into the `origin` you must _force push_  your changes (This is purely for demonstration purposes - do not actually modify the commmit history of the `kim-api` repo)
        ```sh
        git push -f origin; # the -f flag to force-push
        ```
    > If you followed through on the above steps, your `kim-api` repo is now diverging from the `upstream`. To rectify this execute the following command

        ```sh
        git reset --hard 9ed96a89;  # hard reset to the latest common ancestor
        git pull;                   # pull from upstream into local
        ``` 

- #### 3) To `reword` commit messages
    - If you wish to modify the commit message of  __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span> "Fix typo in NEWS"__ we begin by jotting down the commit-hash of the previous commit __<span style = "color:rgb(213, 186, 30);background-color:black">9ed96a89</span> "Bump version to v2.4.2"__ and executing `git rebase -i 9ed96a89`
    - In the text-editor, replace the prefix `pick` with `reword` and Save and Exit the editor. 
        
        <img src = "./commit-history/reword-1.png" style="width:480px">
    - This will open a subsequent text-editor window where you may edit the commit message for __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span> "Fix typo in NEWS"__. For example here I've modified it to __"Fix Multiple Typo in the NEWS document"__. Save and Exit this editor. 
        
        <img src = "./commit-history/reword-2.png" style="width:480px">
    - Confirm that the commit message has been modified. 
        
        <img src = "./commit-history/reword-3.png" style="width:480px">
        <img src = "./commit-history/reword-4.png" style="width:480px">



- #### 4) To `squash` multiple commits into a single commit
    - Consider the following 3 recent commits to the `kim-api`'s  `devel`. They modify the logging code. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">66a0e94b</span> "Adjustments to logging code"__. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">f18e2feb</span> "Add library path to output of collections management 'list'"__. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">93ed6e9d</span> "Added info. logging of shared library paths"__. 
    - These 3 commits modify the logging code. So, they could be combined into a single monolithic commit to reduce the commit-history. 
    - Begin by executing `git rebase -i f7b004ef` where __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span>__ is the commit-hash of the commit before the first commit __<span style = "color:rgb(213, 186, 30);background-color:black">93ed6e9d</span> "Added info. logging of shared library paths"__. 
    - At the text-editor window, replace the prefix `pick` with `squash` for all the commits that you wish to collape into the previous commit. Save and Exit the text-editor. 
        
        <img src = "./commit-history/squash-1.png" style="width:480px">
    - A subsequent text-editor window will open. In this window, comment out all the commits that you wish to squash by prefixing them with a `#`. Save and Exit the text-editor window.

        <img src = "./commit-history/squash-2.png" style="width:480px">

    - Confirm that the commits have been squashed 
        
        <img src = "./commit-history/squash-3.png" style="width:480px">
        <img src = "./commit-history/squash-4.png" style="width:480px">

- #### 5) To `reorder` commit history
    - Consider the following 3 recent commits to the `kim-api`'s  `devel` branch. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span> "Fix typo in NEWS"__. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">9ed96a89</span> "Bump version to v2.4.2"__. 
        - __<span style = "color:rgb(213, 186, 30);background-color:black">fbadf754</span> "Update NEWS for v2.4.1"__. 
    - The commmits __<span style = "color:rgb(213, 186, 30);background-color:black">f7b004ef</span>__ and __<span style = "color:rgb(213, 186, 30);background-color:black">fbadf754</span>__ modify the __NEWS__ document but they're interrupted by the commit __<span style = "color:rgb(213, 186, 30);background-color:black">9ed96a89</span>__ which bumps the version number. It would be ideal if the two commits modifying the NEWS document could be reordered next to each other. 
    
    - We need to rebase our branch to the commit before __<span style = "color:rgb(213, 186, 30);background-color:black">fbadf754</span>__ i.e __<span style = "color:rgb(213, 186, 30);background-color:black">d35b32ec</span> "Improve create-package script"__. 
    ```sh
    git rebase -i d35b32ec;
    ```
    - In the text-editor window, rearrange the order of the commits by cutting (`CTRL+K`) and pasting (`CTRL+U`) them into the desired order. 
    
        <table border="1" cellpadding="6" cellspacing="0" style="border-collapse: collapse; text-align: center;">
        <thead>
            <tr>
            <th style="border: 1px solid #ccc;">Original</th>
            <th style="border: 1px solid #ccc;">Reordered</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <td style="border: 1px solid #ccc;"><img src="./commit-history/reorder-1.png" width="480px"></td>
            <td style="border: 1px solid #ccc;"><img src="./commit-history/reorder-2.png" width="480px"></td>
            </tr>
        </tbody>
        </table>
    
    - After reordering the commits, Save and Exit the text-editor. 
    - Confirm that the commits have been squashed 
        
        <img src = "./commit-history/reorder-3.png" style="width:480px">

        <img src = "./commit-history/reorder-4.png" style="width:480px">
    
- #### 6) To `edit` a specific commit
    - You can use `git rebase` to modify the contents of an existing commit. 
    - As before, rewind the branch to a commit before the commit you wish to edit. 
    - In the text-editor window,  replace the prefix `pick` with `edit` for the commits you wish to edit. 
    - Save and Exit the text-editor. 
    - Git will start applying the commits one by one and when it gets to the commit you prefixed with `edit`, it will halt the rebase process.
    - Now you can open VSCode and make any further edits to the codebase that you wish to include in the commit. 
    - Once you've made the required edits execute `git rebase --continue`. 


## Rebase Exercise 


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
- Check the status and history of your repo: 
    ```sh
    git status; 
    git log; 
    git log --oneline; 
    git log --oneline -n 10; # show last 10 commits
    ```
    
- Cherry-Pick a commit from another branch into your branch
    ```sh
    git cherry-pick <commit-hash>; #<commit-hash> refers to a commit on another branch
    ```

- Undo changes to your file/folder before you've staged them 
    ```sh
    git restore </path/to/file>; # for a specific file
    git restore </path/to/folder>; # for an entire folder
    ```
- Un-stage your files if you've mistakenly staged them 
    ```sh
    git restore --staged </path/to/file>;
    git restore --staged </path/to/folder>;
    ```
- Rewind commit-history to an earlier commit.
    ```sh
    git reset --mixed <commit-hash>; # unstage the changes
    git reset --soft <commit-hash>; # keep changes staged
    git reset --hard <commit-hash>; # undo changes to file
    
    git reset --<hard/mixed/soft> HEAD~N; # move head to commit_hash, N-commits back 
    ```
- Download a Github repo. 
    ```sh
    git clone --recursive <repo-url>; # --recursive gets all submodules
    # the <repo-url> could be either HTTPS or SSH link
    # a submodule is another Github repo which the main Github repo links to
    ```

- Save your work-in-progress
    ```sh
    git stash push -m "WIP - bugfix";   # save your uncommited diff 
    git stash list;                     # list all the stashes
    git stash apply stash{<N>}          # apply specific stash 
    ```
## Bonus - github.io static webpage