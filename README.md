# MockBalm

[![CI Status](https://img.shields.io/travis/gllittler/MockBalm.svg?style=flat)](https://travis-ci.org/gllittler/MockBalm)
[![Version](https://img.shields.io/cocoapods/v/MockBalm.svg?style=flat)](https://cocoapods.org/pods/MockBalm)
[![License](https://img.shields.io/cocoapods/l/MockBalm.svg?style=flat)](https://cocoapods.org/pods/MockBalm)
[![Platform](https://img.shields.io/cocoapods/p/MockBalm.svg?style=flat)](https://cocoapods.org/pods/MockBalm)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MockBalm is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MockBalm'
```

## Setup
1. Copy sourcery files into local project. This can be done manually, or using `bundle exec fastlane copyResources` if you are using `appstarter-pod-ios`.
1. Add a file called `LocalImports.stencil` to the same directory as your copied sourcery files. In this file add any `import` and `@testable import` statements that are needed for the local project
1. Add a `.sourcery.yml` file to the root of the project. An example can be copied from `/MockBalm/Resources/Sourcery/Config/.sourcery.yml` (don't forget to edit it to work with the specific project)


## Author

gllittler, g_earnshaw@hotmail.com

## License

MockBalm is available under the MIT license. See the LICENSE file for more info.
