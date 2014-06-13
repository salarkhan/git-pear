#!/bin/sh

function ping_github {
    user_data=$(curl -i https://api.github.com/users/$1)
}

function pull_email {
    echo $user_data | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep "email" | cut -d':' -f2
}

ping_github raorao
pull_email
