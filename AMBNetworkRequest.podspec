Pod::Spec.new do |s|

  s.name         = "AMBNetworkRequest"
  s.version      = "1.0.0"
  s.summary      = "阿米巴网络技术科技有限公司内部网络库。"
  s.homepage     = "https://github.com/jadynJT/AMBNetworkRequest"
  s.license      = "MIT"
  s.author       = { "jadynJT" => "695331437@qq.com" }
  s.source       = { :git => "https://github.com/jadynJT/AMBNetworkRequest.git", :tag => "1.0.0" }

  s.source_files  = "AMBNetworkRequest/AMBNetworkRequest/AMBNetworkRequest.h"

  s.subspec 'Common' do |ss|
    ss.source_files  = "AMBNetworkRequest/AMBNetworkRequest/Common/*.{h,m}"
  end

  s.subspec 'NetworkBLController' do |ss|
    ss.dependency "AMBNetworkRequest/Common"
    ss.source_files  = "AMBNetworkRequest/AMBNetworkRequest/NetworkBLController/*.{h,m}"
  end

  s.subspec 'NetworkReachabilityManager' do |ss|
    ss.source_files  = "AMBNetworkRequest/AMBNetworkRequest/NetworkReachabilityManager/*.{h,m}"
  end

  s.requires_arc  = true
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.dependency "YTKNetwork"
  s.dependency "YYModel"

end
