Pod::Spec.new do |s|
  s.name         = "SicPaySDKHey" # 项目名称
  s.version      = "0.2.0"        # 版本号 与 你仓库的 标签号 对应
  s.license      = "MIT"          # 开源证书
  s.summary      = "A delightful TextField of PhoneNumber" # 项目简介

  s.homepage     = "https://github.com/SicPaySDK/SicPaySDKHey" # 你的主页
  s.source       = { :git => "https://github.com/SicPaySDK/SicPaySDKHey.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  # s.source_files = "Classes/*.{h,m}" # 
  s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "8.0" #平台及支持的最低版本
  
  # User
  s.author             = { "SicPay" => "ztech@sicpay.com" } # 作者信息
  s.social_media_url   = "https://github.com/SicPaySDK" # 个人主页


#特别重要，这里必须配置，否则上传成功，找不到.framework,只有头文件
  s.vendored_frameworks = 'Classes/SicPaySDk.framework'

  s.dependency "OpenSSL"

  s.libraries = "z","c++"



end
