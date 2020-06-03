#/bin/bash

# This program is used for creating branches of main and its submodules.

echo "Tal branch checkouting program is running now."

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
git stash
git pull --rebase
echo "Root project updated."
echo

if [ "$updateGithubs" == "y" ]; then
    GITHUB_PROJECTS="QtComposition qtpromise QtRestClient QtEventBus  log4qt QtJsonSerializer"
    echo "Updating github projects ($GITHUB_PROJECTS)"
    echo
    for g in $GITHUB_PROJECTS
    do
        echo "Updating $g ..."
        cd $g
        echo "Entering $(pwd)"
        git checkout master
        git pull --rebase
        cd ..
        echo
    done
fi

if [ "$updateGithubs" == "y" ]; then
    GITHUB_PROJECTS_2="thirdparty docCovert uibase"
    echo "Updating github projects ($GITHUB_PROJECTS_2)"
    echo
    for g in $GITHUB_PROJECTS_2
    do
        echo "Updating $g ..."
        cd $g
        echo "Entering $(pwd)"
        git checkout develop
        git pull --rebase
        cd ..
        echo
    done
fi

TAL_PROJECTS="EventsLog Account Geometry InkCanvas InteractBase InteractionLib Main QtTalWidget RobotPen Showboard TeachingLib TeachingTools assistant"
echo "Updating tal projects ($TAL_PROJECTS)"
echo
for g in $TAL_PROJECTS
do
    echo "Updating $g ..."
    cd $g
    echo "Entering $(pwd)"
    git stash
    git checkout $targetBranch
    git pull --rebase
    cd ..
    echo
done

TAL_PROJECTS2="Html"
echo "Updating tal projects (TAL_PROJECTS2)"
echo
for g in $TAL_PROJECTS2
do
    echo "Updating $g ..."
    cd $g
    echo "Entering $(pwd)"
    git stash
    git checkout feature/1.8
    git pull --rebase
    cd ..
    echo
done

echo "Entering $(pwd)"
echo "All done."