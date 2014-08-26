#post-commit hook
Pear believes in the Rule of Silence. It also believes that the user should know as little as possible about Pear's inner workings. In order to achieve this, the meat of it's implementation lives in a git commit hook.

In the hook, there are 4 main actions that occur.
* Prevent recursion
    * The `git commit --amend` that the post-commit hook calls at the end will cause the hook to fire again, and again, and again...
    * To get around this, we export an environment variable to the git hook subshell. When our `git commit --amend` fires up a new subshell inside the old one, we check for the existence of that environment variable and exit.
* Get/set the author & committer for the current commit
* Cycle the author & committer for the next commit
* Amend the current commit.
    * We amend commits in the post-hook because the constructing them in the pre-hook broke certain permutations of `git commit *`.
    * We pass `--no-edit` so that the editor doesn't pop up again to allow you to edit the commit message
    * We pass --quiet to suppress unnecessary additional information that is sent to stdout. #RuleOfSilence
    * We pass --allow-empty because failing to do so will result in a fatal error if the current commit passes --allow-empty.

#libexec
`Pear` believes in single responsibility. In order to achieve this, each piece of functionality lives in a self contained program. Each of these programs lives in libexec.

Explain the following clearly because it's dope as fuck
```
pear_commands_dir=$pear_dir/libexec
command_path=$pear_commands_dir/$command
exec $command_path "${@:2}"
```
