Pod::Spec.new do |s|

  s.name         = "ESArcProgressView"
  s.version      = "1.3"
  s.author       = { "bvkuijck" => "Bas van Kuijck <bas@e-sites.nl>" }
  s.license 	   = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "A progress view to be used within Apple Watch projects."
  s.source       = { :git => "https://github.com/e-sites/ESArcProgressView.git", :tag => s.version.to_s   }
  s.homepage     = "https://github.com/e-sites/ESArcProgressView"
  s.source_files = "Classes/*.{h,m}"
  s.platform     = :ios, '7.0'
  s.frameworks = 'QuartzCore'
  s.requires_arc = true
end