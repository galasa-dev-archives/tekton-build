#!/bin/bash

deleteRepo() {
    local repo=$1

    git clone --branch main git@github.com:galasa-dev/$repo.git $repo

    cd $repo
#    git branch -d $targetBranch

    git push origin --delete $targetBranch

    echo "Deleted $targetBranch from $repo"
    echo ""
    echo ""
    cd ..
}

if [ -z ${1+x} ]; then echo "target branch not provided"; exit 1; else echo "target branch is $1"; fi

if [ "main" == $1 ]; then echo "Must not delete main"; exit; fi

targetBranch=$1

echo "deleting repos directory"
rm -rf repos
mkdir repos
echo ""
echo ""

cd repos
deleteRepo gradle        
deleteRepo maven         
deleteRepo framework     
deleteRepo extensions    
deleteRepo managers      
deleteRepo obr           
deleteRepo docker        
deleteRepo isolated      
deleteRepo eclipse       
deleteRepo cli           
deleteRepo tekton-build  


echo "deleting namespace"
kubectl delete namespace galasa-dev-$targetBranch --wait=false

echo "complete"
