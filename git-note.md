

## create new branch from another
git checkout -b new-branch old-branch;
git checkout old-branch
git push --set-upstream origin new-branch;

## checkout a branch
git checkout branchname



# Merge code from feature branch 'dev-branch' to master
# ...develop some code...

 git add –A
 git commit –m "Some commit message"
 git checkout master
Switched to branch 'master'
 git merge dev-branch  (this is to merge changes from dev-branch to master)
git push (push changes in master branch)
