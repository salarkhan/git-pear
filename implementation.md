#post-commit hook
In order for `git-pear` to operate as quietly and unobtrusively as possible, the meat of it's implementation lives in a git commit hook.

In the hook, there are 4 main actions that occur.
* Prevent recursion
    * The `git commit --amend` that `set-author-committer` calls at the end will cause the post-commit hook to fire again, and again, and again...
    * To get around this, we export an environment variable to the git hook subshell. When our `git commit --amend` fires up a new subshell inside the old one, we check for the existence of that environment variable and exit.
* Get/set the author & committer for the current commit
* Cycle the author & committer for the next commit
* Amend the current commit.
    * We amend commits in the post-hook because the constructing them in the pre-hook broke certain permutations of `git commit *`.
    * We pass `--no-edit` so that the editor doesn't pop up again to allow you to edit the commit message
    * We pass --quiet to suppress unnecessary additional information that is sent to stdout. #RuleOfSilence
    * We pass --allow-empty because failing to do so will result in a fatal error if the current commit passes --allow-empty.
