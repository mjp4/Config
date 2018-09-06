#! /bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

for filename in `ls -A $DIR`
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

for dirname in `ls -A $DIR`
do
    if [ -d $DIR/$dirname -a $dirname != ".git" ]
    then 
        for filename in `ls -A $DIR/$dirname`
        do
            if [ -e ~/$dirname/$filename -a ! -h ~/$dirname/$filename ]
            then
                mv ~/$dirname/$filename ~/$dirname/$filename~ && echo "Backed up existing ~/$dirname/$filename"
            fi
            mkdir ~/$dirname
            ln -s $DIR/$dirname/$filename ~/$dirname/ && echo "Linked ~/$filename to $DIR/$dirname/$filename"
        done
    fi
done

chmod og= $DIR/.ssh/config

# Install Vim Bundles
if [ -d $DIR/.vim -a ! -f ~/.vim/bundle/Vundle.vim ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim -i NONE -c VundleUpdate -c quitall
fi

# Install standard desired programs.
DesiredPrograms="vim git openssh tmux sshfs python3 python3-pip sshpass"
yum install $DesiredPrograms ||\
sudo yum install $DesiredPrograms ||\
apt-get install $DesiredPrograms ||\
sudo apt-get install $DesiredPrograms ||\
echo "No Package Manager available"
