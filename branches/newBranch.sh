#!/bin/bash

cloneRepo() {
    local repo=$1

    cd $reposDir
    
    git clone --branch $sourceBranch git@github.com:galasa-dev/$repo.git $repo

    cd $repo
    git checkout -f -B $targetBranch

    git push -f origin $targetBranch

    echo "Cloned $repo"
    echo ""
    echo ""
}



set -e

if [ -z ${1+x} ]; then echo "source branch not provided"; exit 1; else echo "Source branch is $1"; fi
if [ -z ${2+x} ]; then echo "target branch not provided"; exit 1; else echo "Target branch is $2"; fi

branchesDir=$PWD
reposDir="/tmp/galasarepos"

sourceBranch=$1
targetBranch=$2

echo "deleting repos directory"
if [ -d $reposDir ]; then rm -rf $reposDir; fi
mkdir $reposDir
echo ""
echo ""

cd $reposDir
cloneRepo gradle        
cloneRepo maven         
cloneRepo framework     
cloneRepo extensions    
cloneRepo managers      
cloneRepo obr           
cloneRepo docker        
cloneRepo isolated      
cloneRepo eclipse       
cloneRepo cli           
cloneRepo tekton-build  



kubectl create namespace galasa-dev-$targetBranch

kubectl get secret gpgkey --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-dev-$targetBranch -f -
kubectl get secret gpggradle --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-dev-$targetBranch -f -
kubectl get secret mavengpg --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-dev-$targetBranch -f -
kubectl get secret harbor-user-pass --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-dev-$targetBranch -f -

cd $branchesDir/helm

helm -n galasa-dev-$targetBranch install $targetBranch .

kubectl create -n galasa-dev-$targetBranch -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml

echo "Complete"
