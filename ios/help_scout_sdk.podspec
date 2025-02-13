#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint help_scout_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'help_scout_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # HelpScout Beacon dependency
  s.dependency 'Beacon', '3.0.1'
  s.preserve_paths = 'Beacon.framework'
    s.xcconfig = { 'OTHER_LDFLAGS' => '-framework Beacon' }
    s.vendored_frameworks = 'Beacon.framework'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
