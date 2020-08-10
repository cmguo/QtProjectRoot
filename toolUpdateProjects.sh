#/bin/bash

echo "Tal branch checkouting program is running now, the trick is parcing .gitmodules for key information."
echo

echo "Before run this script, make sure you have clone your submodules properly by calling [git submodule update]"
echo

currentBranch=$(git symbolic-ref --short HEAD)
read -p "Current branch is $currentBranch, are you sure to continue? Please ensure your current branch is clean, submodules are set correctly. Press any key to contine, [ctrl + c]  to stop." -n 1 -r
echo

targetBranch=$currentBranch
while [ "$targetBranch" == "" ]; do
  read -p "Please input your target branch name: " targetBranch
done

echo "Updating root project ..."
git fetch
git checkout $targetBranch
git pull --rebase
echo "Root project updated."
echo "Done"
echo
echo

echo "Starting updating submodules by parcing \".gitmodules\" file"
echo

TargetPath=""
TargetBranch=""

cat ./.gitmodules | while read LINE
do
        if [[ "$LINE" == "[submodule"* ]]; then
              TargetPath=""
              TargetBranch=""
        fi

        if [[ "$LINE" == "path"*"="* ]]; then
              TargetPath=$(echo "${LINE##*=}" | tr -d " \t\n\r")
        fi

        if [[ "$LINE" == "branch"*"="* ]]; then
              TargetBranch=$(echo "${LINE##*=}" | tr -d " \t\n\r")
        fi

        if [[ $TargetPath != "" &&  $TargetBranch != "" ]]; then
              echo "Checking module \"$TargetPath\" of branch \"$TargetBranch\" "
              cd $TargetPath
              echo "Entering $(pwd)"
              git fetch
              git checkout $TargetBranch
              git pull --rebase
              cd ..
              echo "Entering $(pwd)"
              echo "Done"
              echo
              echo
              TargetPath=""
              TargetBranch=""
        fi

done