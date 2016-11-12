

Pod::Spec.new do |s|


  s.name         = “DQPlistManage”
  s.version      = “0.0.1”
  s.summary      = “DQPlistManage.”
  s.homepage     = "https://github.com/wu890608/DQPlistManage"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "大强" => "997121430@qq.com" }
  s.platform     = :ios, "5.0"
  s.ios.deployment_target = "5.0"
  s.source       = { :git => "https://github.com/wu890608/DQPlistManage.git", :tag => “0.0.1” }
  s.source_files  = "*.{h,m}"
  s.frameworks  = "Foundation"
end
