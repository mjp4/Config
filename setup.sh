#! /bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

for filename in `ls -a $DIR`
do
    if [ -f $DIR/$filename -a $filename != "setup.sh" ]
    then
        if [ -e ~/$filename -a ! -h ~/$filename ]
        then
            mv ~/$filename ~/$filename~ && echo "Backed up existing ~/$filename"
        fi
        ln -s $DIR/$filename ~/$filename && echo "Linked ~/$filename to $DIR/$filename"
    fi

done

mkdir $DIR/.vim
mv ~/.vim/ftplugin ~/.vim/ftplugin~
ln -s $DIR/.vim/ftplugin ~/.vim/

mkdir $DIR/.ssh
mv ~/.ssh/config ~/.ssh/config~
ln -s $DIR/Config/.ssh/config ~/.ssh/
