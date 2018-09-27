Pod::Spec.new do |s|

    s.requires_arc = true
    s.license      = "MIT"
    s.authors      = { "CSH" => "624089195@qq.com" }
    s.platform     = :ios, "7.0"
    s.name         = "SHAlertView"
    s.version      = "1.0.1"
    s.summary      = "悬浮框"
    s.homepage     = "https://github.com/CCSH/SHAlertView"
    s.source       = { :git => "https://github.com/CCSH/SHAlertView.git", :tag => s.version }
    s.source_files = "SHAlertView/*.{h,m}"
    s.dependency    "SHClickTextView","1.0.3"

end
