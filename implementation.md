#post-commit hook
Pear believes in the Rule of Silence. It also believes that the user should know as little as possible about Pear's inner workings. In order to achieve this, the meat of it's implementation lives in a git commit hook.

In the hook, 4 distinct actions occur:
* __Prevent recursion__
    * The `git commit --amend` that the post-commit hook calls at the end will cause the hook to fire again, and again, and again...
    * To get around this, Pear exports an environment variable to the git hook subshell. When `git commit --amend` fires up a new subshell inside the old one, Pear checks for the existence of that environment variable and exits.
* __Get/set the author & committer for the current commit__
* __Cycle the author & committer for the next commit__
* __Amend the current commit__
    * Pear amends commits in the post-hook because the constructing them in the pre-hook breaks certain permutations of `git commit *`.
    * Pear passes `--no-edit` so that the editor doesn't pop up again to allow the user to edit the commit message
    * Pear passes `--quiet` to suppress unnecessary additional information that is sent to stdout. #RuleOfSilence
    * Pear passes `--allow-empty` because while the initial commit is ok with an empty commit if passed `allow-empty`, the amended commit is not. 

#libexec
Pear believes in single responsibility. In order to achieve this, each piece of functionality lives in a self contained program. Each of these programs lives in libexec.
