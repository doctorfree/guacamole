#!/bin/bash

gitpath="https://github.com/apache"
project="guacamole-client"
patch_dir="$HOME/src/patches-projects/${project}"
here_dir=`pwd`
ask=1
[ "$1" == "-y" ] && ask=

[ -d ${project} ] && {
    rm -rf ${project}-
    mv ${project} ${project}-
}

git clone $gitpath/${project}.git

pnum=0
for patch in $patch_dir/*.patch
do
    [ "$patch" == "$patch_dir/*.patch" ] && continue
    b=`basename $patch`
    patch_name=`echo $b | sed -e "s/.patch//"`
    while true
    do
        if [ "$ask" ]
        then
            read -p "Do you want to apply the patch for $patch_name ? (y/n) " yn
        else
            yn="y"
        fi
        case $yn in
            [Yy]* )
                [ -r ${patch} ] && {
                    cd ${project}
                    suff=".0$pnum"
                    patch -b -z $suff -p0 < ${patch}
                    pnum=`expr $pnum + 1`
                    cd $here_dir
                }
                break;;
            [Nn]* ) printf "\nSkipping $patch_name.\n"; break;;
                * ) echo "Please answer yes or no.";;
        esac
    done
done
