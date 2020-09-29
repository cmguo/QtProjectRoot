#/bin/bash

echo "Tal project releasing program is running now, the trick is parcing .gitmodules for key information."
echo

echo "Before run this script, make sure you have calling toolUpdateProject.sh properly."
echo

currentBranch=$(git symbolic-ref --short HEAD)
read -p "Current branch is $currentBranch, are you sure to continue? Please ensure your current branch is clean, and submodules are set correctly. Press any key to contine, [ctrl + c]  to stop." -n 1 -r
echo

targetBranch=""
while [ "$targetBranch" == "" ]; do
  read -p "Please input your target branch name: " targetBranch
done

echo "Release root module from branch \"$currentBranch\" to $targetBranch"
git checkout -b $targetBranch
git push --set-upstream origin $targetBranch
echo "Root project is released."
echo "Done"
echo
echo

echo "Starting releasing submodules by parcing \".gitmodules\" file"
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
              echo "Release module \"$TargetPath\" of branch \"$TargetBranch\" to $targetBranch"
              cd $TargetPath
              echo "Entering $(pwd)"
              git checkout -b $targetBranch
              git push --set-upstream origin $targetBranch
              cd ..
              echo "Entering $(pwd)"
              echo "Done"
              echo
              echo
              TargetPath=""
              TargetBranch=""
        fi

done