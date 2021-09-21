# Galasa Branch level development

The build process of Galasa has been changed to allow a full build of Galasa from any branch in the main repos (ie, it wont work for forks).  The same branch must be created on all the appropriate repos for the build to work.  The repos covered by this build process are:-
1. gradle
1. maven
1. framework
1. extensions
1. managers
1. obr
1. docker
1. eclipse
1. isolated

# Branch names

Any lowercase a-z 0-9 can be used, but convention will be to use "iss987" as an example, using the issue number you are working on.

# Kubernetes namespace

The build process requires a Kubernetes namespace to run the tekton builds and to host the transient maven repository http servers. This way all build and hosting resources are contained in one place, so it is isolated from the main builds and can be cleaned easily.

You will need to authenticate with kubernetes using the cicsk8s tool, a executable can be found for your operating system can be found at [https://cicscit.hursley.ibm.com/cit/cicsk8s/](https://cicscit.hursley.ibm.com/cit/cicsk8s/).

# Creating a branch build

Unfortunately, at the moment, this has to be done by someone with full admin authority on our Kubernetes, so with Michael or James.

In the tekton-build repository, there is a "branches" directory, in here is "newBranch.sh".  Create a new branch in all the repos and create all the k8s and tekton resources by issuing the command:-
```
./newBuild.sh main iss876
```
assuming you want to base the build off of "main",  you can base of a take if you wish.

# Deleting a branch build

Once finished with the branch:-
```
./deleteBranch.sh iss876
```
still need to develop the harbor image deletes

# Building a branch

You will need to download 2 executables,  kubectl and tkn.  For kubectl see [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/), or kubernetes is currently at 1.17.
For tkn, see [https://tekton.dev/docs/cli/](https://tekton.dev/docs/cli/) or download a binary from the releases page at [https://github.com/tektoncd/cli/releases](https://github.com/tektoncd/cli/releases)

The build process uses Tekton to build Galasa, all the pipelines and tasks have been created in the namespace.   The builds must be built using the pipeline runs found in the branches/pipelineRuns folder in the tekton-build repo in the following order:-
```
kubectl -n galasa-dev-iss876 create -f gradle-build.yaml
kubectl -n galasa-dev-iss876 create -f maven-build.yaml
kubectl -n galasa-dev-iss876 create -f runtime-build.yaml
kubectl -n galasa-dev-iss876 create -f eclipse-build.yaml
kubectl -n galasa-dev-iss876 create -f isolated-build.yaml
```
Run them one at a time, as each build is the input to the next one.  Please run all the builds when you receive the new branch, as it will clear all errors from the kubernetes cluster.


eclipse and isolated are only required once you need to perform the full regressions runs against your build.   gradle and maven normally only need to be built once.

you can review and monitor the builds using the tkn command tool
examples:-

```
tkn -n galasa-dev-iss876 pipelineruns list
tkn -n galasa-dev-iss876 pipelineruns logs -f --last
tkn -n galasa-dev-iss876 pipelineruns logs runtime-build-992xb
tkn -n galasa-dev-iss876 pipelineruns list delete runtime-build-992xb
```