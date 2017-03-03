#
# Be sure to run `pod lib lint BaseFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BaseFramework'
    s.version          = '0.2.0'
    s.summary          = '常用的类'

    s.description      = <<-DESC
    搭建项目框架常用的类
                       DESC

    s.homepage         = 'https://github.com/zhonglaoban'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '钟凡' => '1049056949@' }
    s.source           = { :git => 'https://github.com/zhonglaoban/BaseFramework.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'

    s.subspec 'CommonViews' do |commonViews|
    commonViews.source_files = 'BaseFramework/CommonViews/**/*.{h,m,swift}'
    commonViews.public_header_files = 'BaseFramework/ComonViews/**/*.h'
    commonViews.dependency 'SDWebImage'
    commonViews.resource = 'BaseFramework/CommonViews/**/*.{xib,png,bundle}'
    end

    s.subspec 'Extension' do |extension|
    extension.source_files = 'BaseFramework/Extension/**/*.{h,m,swift}'
    extension.public_header_files = 'BaseFramework/Extension/**/*.h'
    end

    s.subspec 'Tool' do |tool|
    tool.source_files = 'BaseFramework/Tool/**/*.{h,m,swift}'
    tool.public_header_files = 'BaseFramework/Tool/**/*.h'

    end

end
