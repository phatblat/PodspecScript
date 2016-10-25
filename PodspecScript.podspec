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

  # Non-source files get stripped without this
  s.preserve_paths  = 'run_script.sh', 'install_run_script.rb'

  puts "#----------------------------------------------------------------------------#"
  puts 'local_variables' # [:s, :string, :path, :e, :message]
  # s:        The Pod::Spec object
  # string:   Contents of .podspec file
  # path:     Absolute path to .podspec
  # e:        <empty>
  # message:  <empty>
  local_variables.each do |var|
    puts var.to_s + " >> " + eval(var.to_s).to_s
  end
  puts

  puts "#----------------------------------------------------------------------------#"
  puts "Arguments to pod command:"
  ARGV.each_with_index do |arg, index|
    puts "ARGV[#{index}]: #{arg}"
  end

  puts "#----------------------------------------------------------------------------#"
  # prepare_command
  #
  # > If the pod is installed with the :path option this command will not be executed.
  # > https://guides.cocoapods.org/syntax/podspec.html#prepare_command
  # In practice, I've found that prepare_command is _sometimes_ called even when pod is
  # installed with the :path option.
  #
  # path variable is the Absolute path to .podspec, provided by CocoaPods
  s.prepare_command = <<-CMD
    echo "prepare_command"
    ruby install_run_script.rb '#{path}'
  CMD
end
