#
# Be sure to run `pod lib lint HYPDatePopoverViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HYPDatePopoverViewController"
  s.version          = "0.1.0"
  s.summary          = "Want to put a date picker in a popover? We got you covered."
  s.description      = <<-DESC
                       Want to put a date picker in a popover? We got you covered.

                       * Delegate for choosing a date
                       * Get a candy for using this pod
                       DESC
  s.homepage         = "https://github.com/hyperoslo/HYPDatePopoverViewController"
  s.license          = 'MIT'
  s.author           = { "Elvis Nuñez" => "elvisnunez@me.com" }
  s.source           = { :git => "https://github.com/hyperoslo/HYPDatePopoverViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'HYPDatePopoverViewController' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
