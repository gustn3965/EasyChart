
Pod::Spec.new do |spec|

  spec.name         = "EasyChart"
  spec.version      = "0.2.3"
  spec.swift_version = "5.0"
  
  spec.summary      = "Creating simple chart"
  spec.description  = "This is simple chart. Just initialize  with simple data, then you will get chart view. You can drag on chart to see specific data."

  spec.homepage     = "https://github.com/gustn3965/EasyChart"

  spec.license      = "MIT"
  spec.author             = { "gustn3965" => "gustn3965@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/gustn3965/EasyChart.git", :tag => "#{spec.version}" }

  spec.source_files  = "EasyChart/"
end
