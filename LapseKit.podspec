Pod::Spec.new do |s|
  s.name         = 'LapseKit'
  s.version      = '0.1'
  s.summary      = 'Objective-C client for the Everlapse API.'
  s.homepage     = 'https://github.com/seesawco/LapseKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Caleb Davenport' => 'caleb@seesaw.co', 'Sam Soffes' => 'sam@seesaw.co' }
  s.source       = { :git => 'https://github.com/seesawco/LapseKit.git', :tag => '0.1' }
  
  s.platform     = :ios, '5.0'
  
  s.source_files = 'LapseKit/**/*.{h,m}'
  
  s.requires_arc = true
  
  s.dependency 'AFNetworking'
end
