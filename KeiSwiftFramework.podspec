#
# Be sure to run `pod lib lint KeiSwiftFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KeiSwiftFramework"
  s.version          = "0.4.0"
  s.summary          = "Swift Utility Framework"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Kei's Swift Utility Framework"

  s.homepage         = "https://github.com/meetkei/KeiSwiftFramework"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Keun young Kim" => "app@meetkei.com" }
  s.source           = { :git => "https://github.com/meetkei/KeiSwiftFramework.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/iamkimkeunyoung>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeiSwiftFramework/**/*'
  
  # s.resource_bundles = {
  #   'KeiSwiftFramework' => ['KeiSwiftFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
