#! /bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR
exit

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

for dirname in `ls -a $DIR`
do
    for filename in `ls -a $DIR/$dirname`
    do
        if [ -e $DIR/$dirname/$filename ]
        then
            if [ -e ~/$dirname/$filename -a ! -h ~/$dirname/$filename ]
            then
                mv ~/$dirname/$filename ~/$dirname/$filename~ && echo "Backed up existing ~/$filename"
            fi
            ln -s $DIR/$dirname/$filename ~/$dirname/$filename && echo "Linked ~/$filename to $DIR/$filename"
        fi
    done
done

chmod og= $DIR/.ssh/config
