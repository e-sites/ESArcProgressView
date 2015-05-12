Pod::Spec.new do |s|

  s.name         = "ESArcProgressView"
  s.version      = "1.6.3"
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.author       = { "bvkuijck" => "Bas van Kuijck <bas@e-sites.nl>" }
  s.license 	   = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "A progress view to be used within Apple Watch projects."
  s.source       = { :git => "https://github.com/e-sites/ESArcProgressView.git", :tag => s.version.to_s   }
  s.homepage     = "https://github.com/e-sites/ESArcProgressView"
  s.source_files = 'ESArcProgressView/ESArcProgressView.h'
  s.public_header_files = 'ESArcProgressView/*.h'

  s.subspec 'Core' do |ss|
    ss.source_files = 'ESArcProgressView/ESArcProgressViewCore.{h,m}'
    s.frameworks   = 'QuartzCore'
  end

  s.subspec 'Multiple' do |ss|
    ss.dependency 'ESArcProgressView/Core'
    ss.source_files = 'ESArcProgressView/ESMultipleArcProgressView.{h,m}'
  end

  s.subspec 'Animations' do |ss|
    ss.dependency 'AHEasing', '~> 1.2'
    ss.dependency 'ESArcProgressView/Core'
    ss.source_files = 'ESArcProgressView/ESArcProgressView+Animations.{h,m}'
  end
end
