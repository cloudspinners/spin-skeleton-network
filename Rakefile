
require 'rake/clean'
require 'rake_cloudspin'
require 'rake_docker'
require 'semantic'

CLEAN.include('package')
CLEAN.include('work')
CLEAN.include('dist')
CLOBBER.include('vendor')

task :default => [ :plan ]

RakeCloudspin.define_tasks

namespace :package do

  estate ||= 'my_estate'
  component ||= 'my_component'
  metadata = ENV['GIT_SHA'] || 'LOCAL'
  version = Semantic::Version.new("0.0.1+#{metadata}").to_s
  docker_tag = version.gsub(/[\+]/, '_').downcase

  desc 'Assemble the files to be packaged'
  task :prepare => ['terraform:ensure'] do

    files_for_package = [
      'Dockerfile',
      'go',
      'Rakefile',
      'component.yaml',
      'users.yaml',
      'Gemfile',
      'Gemfile.lock',
      'vendor',
      'account',
      'delivery',
      'deployment'
    ]

    mkpath 'package'
    mkpath "package/#{component}-spinner"

    files_for_package.each { |base_file|
      Find.find(base_file) do |source|
        target = "package/#{component}-spinner/#{source}"
        if File.directory? source
          mkpath target unless File.exists? target
        else
          copy source, target
        end
      end
    }
      # metadata = ENV['GIT_SHA'] || 'LOCAL'
      # version = Semantic::Version.new("0.0.1+#{metadata}")
      # File.open('package/version', 'w') {|f| f.write("#{version.to_s}") }
    # end


    # Rake::PackageTask.new('vpod', Vpod.version) { |p|
    #   p.need_tar = true
    #   p.package_dir = 'dist'
    #   p.package_files.include('package/**/*')
    # }
    File.open("package/#{component}-spinner/version", 'w') {|f| f.write("#{version.to_s}") }
  end

  RakeDocker.define_image_tasks do |t|
    t.image_name = "#{component}-spinner"
    t.work_directory = 'package'

    t.copy_spec = [
      'go',
      'Rakefile',
      'component.yaml',
      'users.yaml',
      'Gemfile',
      'Gemfile.lock',
      'account',
      'delivery',
      'deployment'
    ]

    t.create_spec = [
      {content: version, to: 'VERSION'},
      {content: docker_tag, to: 'TAG'}
    ]

    t.repository_name = "#{estate}/#{component}"
    t.repository_url = "not_implemented"
    t.tags = [docker_tag, 'latest']
  end

  desc 'Clean and build spinner image'
  task :bundle do |_, args|
    Rake::Task["package:clean"].invoke({})
    Rake::Task["package:build"].invoke({})
    Rake::Task["package:tag"].invoke({})
  end

end
