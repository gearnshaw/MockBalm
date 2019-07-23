#
# Be sure to run `pod lib lint MockBalm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MockBalm'
  s.version          = '0.1.9'
  s.summary          = 'A swift library to minimise boilerplate code in mocks.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A swift framework to help you minimise boilerplate code needed to create mocks.

It handles calls to asynchronous functions, and it can be used to mock both classes and protocols.
                       DESC

  s.homepage         = 'https://github.com/gearnshaw/MockBalm'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gearnshaw' => 'g_earnshaw@hotmail.com' }
  s.source           = { :git => 'https://github.com/gearnshaw/MockBalm.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'

  s.source_files = 'MockBalm/Classes/**/*'
  s.resources = 'MockBalm/Resources/**/*'
  
  # s.resource_bundles = {
  #   'MockBalm' => ['MockBalm/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Sourcery', '~> 0.16'
end
