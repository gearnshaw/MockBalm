fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios beforePullRequest
```
fastlane ios beforePullRequest
```
Run before submitting for pull request
### ios releaseNewPodVersion
```
fastlane ios releaseNewPodVersion
```
Run to release the pod. Test and lint, increment the version in the podspec, push to the repo
### ios pods
```
fastlane ios pods
```
Run pod install and update the repo if missing pods
### ios push
```
fastlane ios push
```
Push the pod to the repo
### ios incrementAndTag
```
fastlane ios incrementAndTag
```
Increment the version in the podspec, tag in git, and push the changes
### ios podLint
```
fastlane ios podLint
```
Lint the pod
### ios lint
```
fastlane ios lint
```
Lint the project
### ios tests
```
fastlane ios tests
```
Run project tests
### ios ensureClean
```
fastlane ios ensureClean
```
Ensure that we're on a clean release branch
### ios notifyBuildStart
```
fastlane ios notifyBuildStart
```
Send a message to slack to say that the build has started
### ios notifyBuildSuccess
```
fastlane ios notifyBuildSuccess
```
Send a slack notification to say that the Testflight build was successful
### ios notifyBuildFailure
```
fastlane ios notifyBuildFailure
```
Send a slack notification to say that the build failed
### ios notifyBuild
```
fastlane ios notifyBuild
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
