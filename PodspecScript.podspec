#
# PodspecScript.podspec
#
# An experiment with installing a run script when pod is integrated into an Xcode project.
# Building off of https://gist.github.com/phatblat/87b394ea26a84ba977a6
#

Pod::Spec.new do |s|
  s.name             = 'PodspecScript'
  s.version          = '0.1.0'
  s.summary          = 'A podspec experiment'
  s.description      = <<-DESC
    It would be nice to be able to install a custom build phase run script when CocoaPods
    integrates into a project. I mean, CocoaPods does it for its build phases, so why can't we?
  DESC

  s.homepage         = 'https://github.com/phatblat/PodspecScript'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ben Chatelain' => 'ben@octop.ad' }
  s.source           = { :git => 'https://github.com/phatblat/PodspecScript.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/phatblat'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PodspecScript/Classes/**/*'
end
