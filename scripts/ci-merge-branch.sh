#!/usr/bin/env bash

set -e
usage="USAGE: ./ci-merge-branch.sh --base=<branch-receiving-merge> --merge=<branch-to-merge-into-base> [--trigger=true] [--simulate=false] [--tag=""] \n
        --base \t- [string] the recipient branch \n
        --merge \t- [string] the branch to merge into the 'base' branch \n
        --trigger \t- [bool] dictates whether or not to invoke CI upon successful merge \n
        --simulate \t- [bool] dictates whether the merge should commit or just test if a merge would succeed \n
        --tag \t\t- [string] optional label incorporated into the commit message \n
"
base_branch=""
merge_branch=""
tag=""
trigger="true"
simulate="false"
merge_args=""

for i in "$@"
do
  case $i in
    --base=*) base_branch="${i#*=}"
        shift;;
    --merge=*) merge_branch="${i#*=}"
        shift;;
    --tag=*) tag="${i#*=}"
        shift;;
    --trigger=*) trigger="${i#*=}"
        shift ;;
    --simulate=*) simulate="${i#*=}"
        shift ;;
  esac
done



if [ -z  "$base_branch" ]; then
	echo "unspecified base branch '$base_branch'"
	echo -e $usage
	exit 1
fi

if [ -z  "$merge_branch" ]; then
	echo "unspecified merge branch '$merge_branch'"
	echo -e $usage
	exit 2
fi

if [[ ! "$trigger" =~ (true|false) ]]; then
	echo "invalid trigger value '$trigger' - must be either true or false"
	echo -e $usage
	exit 3
fi

if [[ ! "$simulate" =~ (true|false) ]]; then
	echo "invalid simulate value '$simulate' - must be either true or false"
	echo -e $usage
	exit 4
fi

merge_msg="merge $tag to '$base_branch'"
if [[ "$simulate" == "true" ]]; then
    merge_msg="[simulated] $merge_msg"
fi

echo "merging '$merge_branch' into '$base_branch'"
git fetch --all
git fetch --tags
# ensure we are dealing with clean copies
git checkout $merge_branch && git pull origin $merge_branch --tags
git checkout $base_branch && git pull origin $base_branch --tags

trigger_ci=$([[ "$trigger" == "false" ]] && echo "[skip ci]" || echo "")
merge_args=$([[ "$simulate" == "true" ]] && echo "--no-commit $merge_args" || echo "$merge_args" )

echo "merging - [git merge --no-ff --no-verify $merge_args -m \"chore(release): $merge_msg\" -m \"$trigger_ci\" $merge_branch]"     
result=$(git merge --no-ff --no-verify $merge_args -m "chore(release): $merge_msg" -m "$trigger_ci" $merge_branch || echo "[merge-failed]")        
echo "$result"

if [[ "$result" =~ \[merge-failed\] ]]; then
    echo "merge failed with - resetting & terminating ..."
    git status
    git reset --hard
    exit 1
fi

if [[ "$simulate" == "false" ]]; then
    echo "pushing merge to '$base_branch' ..."
    git push origin $base_branch
fi