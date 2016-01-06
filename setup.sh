#! /bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

for filename in `ls $DIR`
do
    if [ -f $DIR/$filename -a $filename != "setup.sh" ]
    then
        if [ -e ~/$filename ! -h ~/$filename ]
        then
            mv ~/$filename ~/$filename~
            echo "Backed up existing ~/$filename"
        fi
        ln -s $DIR/$filename ~/$filename
        echo "Linked ~/$filename to $DIR/$filename"
    fi

done

mkdir .vim
mv ~/.vim/ftplugin ~/.vim/ftplugin~
ln -s $DIR/.vim/ftplugin ~/.vim/

mkdir .ssh
mv ~/.ssh/config ~/.ssh/config~
ln -s $DIR/Config/.ssh/config ~/.ssh/
