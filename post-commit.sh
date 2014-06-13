#!/bin/sh

# add authors
# usage: auth add salarkhan salar.k3@gmail.com
# result: cat this pair into .git/authors
function create_authors_file {
    test -e ./authors.txt || touch ./authors.txt
}

function add_author {
    echo $1 $2 >> ./authors.txt
}

# set next author
function get_author {
    author_info=$(head -1 authors.txt)
}

function cycle_author {
    sed -i -e '1d' authors.txt
    echo $author_info >> ./authors.txt
}

function set_username {
    git config --local user.name $1
}

function set_email {
    git config --local user.email $1
}

# store default user name & email
# list authors // return authors array
# remove author // remove from hash lookup
# reset authors to default // empty authors array

# get user email from their username
function ping_github {
    user_data=$(curl -i https://api.github.com/users/$1)
}

function pull_email {
    echo $user_data | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep "email" | cut -d':' -f2
}


#DRIVER CODE
#ping_github raorao
#pull_email

create_authors_file
#add_author 'whattauuupp' 'lass'
get_author
cycle_author
