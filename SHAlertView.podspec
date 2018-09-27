Pod::Spec.new do |s|

    s.name         = "SHAlertView"
    s.version      = "1.0.0"
    s.summary      = "悬浮框"
    s.homepage     = "https://github.com/CCSH/SHAlertView"
    s.source       = { :git => "https://github.com/CCSH/SHAlertView.git", :tag => s.version }
    s.source_files = "SHAlertView/*.{h,m}"
    s.dependency    "SHClickTextView","1.0.3"

    s.requires_arc = true
    s.platform     = :ios, "7.0"
    s.license      = "MIT"
    s.authors      = { "CSH" => "624089195@qq.com" }

end
