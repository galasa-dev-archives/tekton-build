#!/bin/bash

set -e

if [ -z ${1+x} ]; then echo "source branch not provided"; exit 1; else echo "Source branch is $1"; fi
if [ -z ${2+x} ]; then echo "target branch not provided"; exit 1; else echo "Target branch is $2"; fi

branchesDir=$PWD
reposDir="/tmp/galasarepos"

targetBranch=$2

if [[ $1 == v* ]];
then
    fromRef="--tag $1"
else 
    fromRef="--branch $1"
fi

galasabld github branch copy --credentials githubcreds.yaml --repository gradle                         $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository maven                          $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository framework                      $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository extensions                     $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository managers                       $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository obr                            $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository docker                         $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository isolated                       $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository eclipse                        $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository cli                            $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository tekton-build                   $fromRef --to $targetBranch 
galasabld github branch copy --credentials githubcreds.yaml --repository integrationtests               $fromRef --to $targetBranch
galasabld github branch copy --credentials githubcreds.yaml --repository galasa-kubernetes-operator     $fromRef --to $targetBranch
galasabld github branch copy --credentials githubcreds.yaml --repository galasa-docker-operator         $fromRef --to $targetBranch 

kubectl create namespace galasa-branch-$targetBranch

kubectl get secret gpgkey --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-branch-$targetBranch -f -
kubectl get secret gpggradle --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-branch-$targetBranch -f -
kubectl get secret mavengpg --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-branch-$targetBranch -f -
kubectl get secret harbor-user-pass --namespace=galasa-tekton -o json | jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid, .metadata.creationTimestamp, .metadata.selfLink)' | kubectl apply --namespace=galasa-branch-$targetBranch -f -

cd $branchesDir/helm

helm -n galasa-branch-$targetBranch install $targetBranch .

kubectl create -n galasa-branch-$targetBranch -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml

echo "Complete"
