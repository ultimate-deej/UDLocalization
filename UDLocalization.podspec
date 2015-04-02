Pod::Spec.new do |s|
  s.name             = "UDLocalization"
  s.version          = "0.1.0"
  s.summary          = "Objective-C localization library"
  s.description      = "Objective-C localization library that swizzles arbitrary string properties or setters (methods that take a single NSString argument)"
  s.homepage         = "https://github.com/ultimate-deej/UDLocalization"
  s.license          = 'MIT'
  s.author           = { "Maxim Naumov" => "ultimate.deej@gmail.com" }
  s.source           = { :git => "https://github.com/ultimate-deej/UDLocalization.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
