#/bin/bash

# This program is used for creating branches of main and its submodules.

echo "Tal branch checkouting program is running now."
echo

echo "Before run this script, make sure you have clone your submodules properly by calling [git submodule update]"
echo

currentBranch=$(git symbolic-ref --short HEAD)
read -p "Current branch is $currentBranch, are you sure to continue? Please ensure your current branch is clean, submodules are set correctly. Press any key to contine, [ctrl + c]  to stop." -n 1 -r
echo

#echo "Try to set submodule to main submitted hashcode"
#git submodule update

targetBranch=$currentBranch
while [ "$targetBranch" == "" ]; do
  read -p "Please input your target branch name: " targetBranch
done

echo "Your target branch is $targetBranch"
echo

updateGithubs="y"
while [ "$updateGithubs" == "" ]; do
  read -p "Do we update githubs? y or n : " updateGithubs
done


echo "Updating root project ..."
git fetch
git checkout $targetBranch
git pull --rebase
echo "Root project updated."
echo

if [ "$updateGithubs" == "y" ]; then
    PROJECTS="QtComposition qtpromise QtRestClient QtEventBus  log4qt QtJsonSerializer"
    echo "Updating github projects ($PROJECTS)"
    echo
    for g in $PROJECTS
    do
        echo "Updating $g ..."
        cd $g
        echo "Entering $(pwd)"
        git fetch
        git checkout master
        git pull --rebase
        cd ..
        echo
    done
fi

if [ "$updateGithubs" == "y" ]; then
    PROJECTS="thirdparty docCovert"
    echo "Updating github projects ($PROJECTS)"
    echo
    for g in $PROJECTS
    do
        echo "Updating $g ..."
        cd $g
        echo "Entering $(pwd)"
        git fetch
        git checkout develop
        git pull --rebase
        cd ..
        echo
    done
fi

PROJECTS="ShowBoard Geometry InkCanvas TeachingTools TeachingLib EventsLog InteractBase InteractionLib Account Main RobotPen UiBase Salt TalWeb Assistant"
echo "Updating tal projects ($PROJECTS)"
echo
for g in $PROJECTS
do
    echo "Updating $g ..."
    cd $g
    echo "Entering $(pwd)"
    git fetch
    git checkout develop/master
    git pull --rebase
    cd ..
    echo
done

PROJECTS="Html"
echo "Updating tal projects ($PROJECTS)"
echo
for g in $PROJECTS
do
    echo "Updating $g ..."
    cd $g
    echo "Entering $(pwd)"
    git fetch
    git checkout feature/1.8
    git pull --rebase
    cd ..
    echo
done

PROJECTS="XhtHtml"
echo "Updating tal projects ($PROJECTS)"
echo
for g in $PROJECTS
do
    echo "Updating $g ..."
    cd $g
    echo "Entering $(pwd)"
    git fetch
    git checkout feature/815
    git pull --rebase
    cd ..
    echo
done

echo "Entering $(pwd)"
echo "All done."