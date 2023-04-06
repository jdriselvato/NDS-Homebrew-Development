This will explain how to use Git to work on MicroLua's source code.

[TOC]


Installation
============

On Linux Git is simply a package often provided in the official repositories and could even be already available on your computer. Simply try `$ git --version` to be sure.

On Windows, I believe the best way to get Git is [msysGit](http://code.google.com/p/msysgit/) which provides a command line interface similar to what is done under Linux (actually thanks to MSys).


Clone the repository
====================

Following your rights on the repository, you will either use the read-only URL 'git://git.code.sf.net/p/microlua/uLua' or the read-write URL 'ssh://___<your name>___@git.code.sf.net/p/microlua/uLua' (do not forget to _replace your name_ within the URL).
    
    ::bash
    cd /path/to/my/global/MicroLua/dir/
    mkdir repo         # or something else
    cd repo            # change it to what you did just above
    
    # If you have read-only access
    git clone git://git.code.sf.net/p/microlua/uLua .
    # Or if you have read-write access
    git clone ssh://___<your name>___@git.code.sf.net/p/microlua/uLua .

Now Git is downloading the whole history, so it can take some time.


Pulling the latest version
==========================

This is achieved by using:

    :::bash
    git pull

This command actually performs:

    :::bash
    git fetch
    git merge

Where `fetch` fetches the new references and files and `merge` merges them onto the current working tree, hoping there won't be any conflict. Otherwise, it's up to you to merge this by a way or the other.  
There should actually be no conflict as the modifications you'd make should be in another branch than 'master'.

Making changes
==============

Create a new branch
-------------------

As said above, you should only make changes on another branch and then merge the changes to the 'master' branch.

This command creates a new branch called "myChanges" and switch the working tree to it.

    :::bash
    git checkout -b myChanges

Now you can simply edit the code.

See what changed
----------------

Git provides a global summary of what changed in the tree:

    :::bash
    git status        # you may have the shortcut 'git st'

And to check what changed on a particular file:

    :::bash
    git diff /path/to/file        # running diff without a path displays diff for every file

Apply the changes
-----------------

Once you are happy with what has changed, you can apply the modifications by _committing_.

First, you add the changes:

    :::bash
    git add /path/to/file1 /path/to/file2
    # Or to add every changed file
    git add -A

Then you commit (on a side branch of course) with:

    :::bash
    git commit

This will open a text editor (usually [Vim](http://www.vim.org/) if installed) in which you can add a commit message explaining what was done. The first line is a shorter summary.

When the whole modification project is done, you may merge it to the main branch 'master'.

    :::bash
    # First, update the branch
    git pull
    # Then, merge your own branch into it
    git merge myChanges

In case of conflict, resolve them and commit the merge.

Commit to the central repository
--------------------------------

If you have write access, a simple

    :::bash
    git push

should be enough.

If you can't commit to the global repository, you can publish a patch by saving the result of `git diff` between the last global commit and yours. You can also ask an administrator for commit rights.