#
# Be sure to run `pod lib lint BaseFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaseFramework'
  s.version          = '0.1.2'
  s.summary          = '常用的类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
搭建项目框架常用的类
                       DESC

  s.homepage         = 'https://github.com/zhonglaoban'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '钟凡' => '1049056949@' }
  s.source           = { :git => 'git@123.57.239.39:zhongfan/BaseFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BaseFramework/Classes/**/*.{h,m,swift}'
  
#s.resource_bundles = {
#  'BaseFramework' => ['BaseFramework/Assets/*']
# }
    s.resource = 'BaseFramework/Classes/**/*.{lproj,storyboard,xib,xcassets,json,imageset,png}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'SDWebImage'
end
