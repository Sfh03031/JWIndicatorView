#
# Be sure to run `pod lib lint JWIndicatorView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWIndicatorView'
  s.version          = '0.1.0'
  s.summary          = 'JWIndicatorView is a subclass of UIView used to implement the loading indicator effect.(JWIndicatorView是一个UIView的子类，用以实现加载指示器效果。)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  JWIndicatorView is a subclass of UIView used to implement the loading indicator effect. At present, it supports 33 different indicator styles and flexible customization, uses chain syntax encapsulation, which makes it easy to read and write.

  (JWIndicatorView是一个UIView的子类，用以实现加载指示器效果。目前它支持33种不同的指示器样式，并支持灵活的自定义，使用链式语法封装，读写简便。)
                       DESC

  s.homepage         = 'https://github.com/Sfh03031/JWIndicatorView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sfh03031' => 'sfh894645252@163.com' }
  s.source           = { :git => 'https://github.com/Sfh03031/JWIndicatorView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_versions   = '5'
  s.ios.deployment_target = '12.0'

  s.source_files = 'JWIndicatorView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JWIndicatorView' => ['JWIndicatorView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'NVActivityIndicatorView'
  
end
