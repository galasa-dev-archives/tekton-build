#!/bin/bash

if [ -z ${1+x} ]; then echo "target branch not provided"; exit 1; else echo "target branch is $1"; fi

if [ "main" == $1 ]; then echo "Must not delete main"; exit; fi

targetBranch=$1

galasabld github branch delete --credentials githubcreds.yaml --repository gradle            --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository maven             --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository framework         --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository extensions        --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository managers          --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository obr               --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository docker            --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository isolated          --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository eclipse           --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository cli               --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository tekton-build      --branch $targetBranch 
galasabld github branch delete --credentials githubcreds.yaml --repository integrationtests  --branch $targetBranch 


galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-gradle             --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-maven              --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-framework          --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-extensions         --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-managers           --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-javadoc            --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-eclipse            --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-isolated           --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-mvp                --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-maven-inttests           --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-ibm-boot-embedded-amd64  --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-boot-embedded-amd64      --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-obr-generic              --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-javadocs                 --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-apidocs                  --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-isolated                 --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-p2                       --tag $targetBranch
galasabld harbor deleteimage --credentials harborcreds.yaml --harbor https://harbor-cicsk8s.hursley.ibm.com --project galasadev --repository galasa-mvp                      --tag $targetBranch


echo "deleting namespace"
kubectl delete namespace galasa-branch-$targetBranch --wait=false

echo "complete"
