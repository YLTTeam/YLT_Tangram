
Pod::Spec.new do |s|
  s.name             = 'YLT_Tangram'
  s.version          = '0.1.0'
  s.summary          = '组件化'

  s.description      = <<-DESC
组件通过配置文件生成页面
                       DESC

  s.homepage         = 'https://github.com/xphaijj/YLT_Tangram'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xphaijj0305@126.com' => 'xianggong@anve.com' }
  s.source           = { :git => 'https://github.com/xphaijj/YLT_Tangram.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'YLT_Tangram/Classes/**/*.h'
  s.source_files = 'YLT_Tangram/Classes/**/*.{h,m}'
  
  s.resource_bundles = {
     'YLT_Tangram' => ['YLT_Tangram/Classes/Config/*.geojson']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'YLT_Kit'
  s.dependency 'RegexKitLite'
end
