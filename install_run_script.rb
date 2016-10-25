#!/usr/bin/env ruby

require 'pathname'
require 'xcodeproj'

path_to_xcode_build_script = '"${SRCROOT}/Pods/POD_NAME/run_script.sh"'
xcode_build_script_name = 'Unique Run Script Name'

puts "Dir.pwd #{Dir.pwd}"

puts "#----------------------------------------------------------------------------#"
puts "Arguments to install_run_script.rb"
ARGV.each_with_index do |arg, index|
  puts "ARGV[#{index}]: #{arg}"
end

path_to_spec = ARGV[0] # Passed from podspec using path variable

if path_to_spec.start_with?('/private/tmp/CocoaPods/Lint')
  # CocoaPods Lint
  # e.g. /private/tmp/CocoaPods/Lint/Pods/Local Podspecs/POD_NAME.podspec

  puts 'CocoaPods linting, bail now before fail'
  exit 0
# elsif path_to_spec.include?('.cocoapods')
#   puts 'Pod installed from spec repo'
#   # podspec: /Users/phatblat/.cocoapods/repos/REPO_NAME/POD_NAME/1.0.0/POD_NAME.podspec
#   # Dir.pwd: /Users/phatblat/APP_PATH/Pods/POD_NAME

#   path_to_project = Dir.glob(Pathname.new(Dir.pwd) + '../../*.xcodeproj')[0]
# else
#   puts 'Pod installed via :path in Podfile'
#   # podspec: /Users/phatblat/LOCAL_POD_PATH/POD_NAME/POD_NAME.podspec
#   # Dir.pwd: /Users/phatblat/LOCAL_POD_PATH/POD_NAME

#   puts "path_to_spec: #{path_to_spec}"
#   puts "Pathname.new(path_to_spec): #{Pathname.new(path_to_spec)}"
#   puts "Dir.glob(Pathname.new(path_to_spec)): #{Dir.glob(Pathname.new(path_to_spec))}"
#   path_to_project = Dir.glob(Pathname.new(path_to_spec) + '../../../*.xcodeproj')[0]
end

# Expand glob path to absolute
# path_to_project = Dir.glob(Dir.pwd + '/*.xcodeproj')[0]
puts path_to_project

project = Xcodeproj::Project.open(path_to_project)
main_target = project.targets.first
script_installed = false

main_target.shell_script_build_phases.each { |run_script|
  script_installed = true if run_script.name == xcode_build_script_name
}

if (!script_installed)
  puts "Installing run script in Xcode project #{path_to_project}"
  phase = main_target.new_shell_script_build_phase(xcode_build_script_name)
  phase.shell_script = path_to_xcode_build_script
  project.save()
else
  puts "Run script already installed"
end

# Script output is hidden unless there is an error
eval(blah)
