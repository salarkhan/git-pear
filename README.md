# git-pear

A simple utility for sharing commit ownership while working in pairs.

## installation
```
git clone https://github.com/salarkhan/git-pear.git
cd git-pear
./install
```

## authentication
Upon team creation, Pear pings GitHub's API to retrieve each member's full name. 
If you expect your IP address to be making more than 60 unauthenticated requests an hour, Pear optionally accepts an  API token. To authenticate, [generate a token via GitHub](https://help.github.com/articles/creating-an-access-token-for-command-line-use) and export it as an environment variable in your `bash_profile`
```
export GIT_API_TOKEN=21231381thisis1231a123github123token8
```

## usage
```pear``` followed by any number of email addresses.
Committers and commit authors will cycle through this list between each commit.

``` bash
pear example1@email.com example2@email.com
```

To quit, type `pear` with no arguments
```
pear
```
