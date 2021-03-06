Pod::Spec.new do |s|
  s.name             = "UDLocalization"
  s.version          = "0.1.0"
  s.summary          = "Objective-C localization library for iOS"
  s.description      = "Objective-C localization library for iOS that swizzles arbitrary string properties or setters (methods that take a single NSString argument)"
  s.homepage         = "https://github.com/ultimate-deej/UDLocalization"
  s.license          = 'MIT'
  s.author           = { "Maxim Naumov" => "ultimate.deej@gmail.com" }
  s.source           = { :git => "https://github.com/ultimate-deej/UDLocalization.git", :tag => s.version.to_s }
  
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/UDLocalization.h'

  s.subspec 'LocalizedStrings' do |ss|
    ss.source_files = 'Pod/LocalizedStrings/*.{h,m}'
  end

  s.subspec 'MethodLocalization' do |ss|
    ss.source_files = 'Pod/MethodLocalization/*.{h,m}'
    ss.dependency 'UDLocalization/LocalizedStrings'
  end

  s.subspec 'ViewLocalization' do |ss|
    ss.source_files = 'Pod/ViewLocalization/*.{h,m}'
    ss.dependency 'UDLocalization/MethodLocalization'
  end
end
