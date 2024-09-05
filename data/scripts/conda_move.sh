#!/bin/bash

OLD_PATH=$1
NEW_PATH=$2
if [ -z $OLD_PATH ] || [ -z $NEW_PATH ]; then
    echo "Usage: $0 <old_path> <new_path>"
    exit 1
fi
if [ ! -d $OLD_PATH ]; then
    echo "Error: $OLD_PATH does not exist."
    exit 1
fi
if [ -d $NEW_PATH ]; then
    NEW_PATH="$NEW_PATH/$(basename $OLD_PATH)"
fi

echo "Start moving conda environment from $OLD_PATH to $NEW_PATH"
mv $OLD_PATH $NEW_PATH

echo "update bin/activate"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/bin/activate
echo "update bin/conda"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/bin/conda
echo "update bin/pip"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/bin/pip
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/bin/pip3
echo "update bin/conda-env"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/bin/conda-env
echo "update etc/profile.d/conda.sh"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/etc/profile.d/conda.sh
echo "update etc/profile.d/conda.csh"
sed -i "s#$OLD_PATH#$NEW_PATH#g" $NEW_PATH/etc/profile.d/conda.csh
