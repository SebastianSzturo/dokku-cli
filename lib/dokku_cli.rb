require 'thor'

require "dokku_cli/version"
require "dokku_cli/config"
require "dokku_cli/domains"
require "dokku_cli/nginx"
require "dokku_cli/ps"

module DokkuCli
  class Cli < Thor
    class_option :remote

    desc "logs [-t]", "Display logs for the app (-t follows)"
    def logs(*args)
      if args.first && args.first.strip == "-t"
        command = "ssh dokku@#{domain} logs #{app_name} -t"
        puts "Running #{command}..."
        exec(command)
      else
        run_command "logs #{app_name}"
      end
    end

    desc "open", "Open the app in your default browser"
    def open
      url = %x[dokku urls].split("\r").first
      exec("open #{url}")
    end

    desc "run <cmd>", "Run a one-off command in the environment of the app"
    def walk(*args)
      command = "#{args.join(' ')}"
      case command.gsub(" ", "")
      when "rakedb:drop"
        puts "You cannot use `rake db:drop`. Use Dokku directly to delete the database."
      when "rakedb:create"
        puts "You cannot use `rake db:create`. Use Dokku directly to create the database."
      else
        run_command "run #{app_name} #{command}"
      end
    end

    desc "ssh", "Start an SSH session as root user"
    def ssh
      command = "ssh root@#{domain}"
      puts "Running #{command}..."
      exec(command)
    end

    desc "url", "Show the first URL for the app"
    def url
      run_command "url #{app_name}"
    end

    desc "urls", "Show all URLs for the app"
    def urls
      run_command "urls #{app_name}"
    end

    def help(method = nil)
      method = "walk" if method == "run"
      super
    end

    def method_missing(method, *args, &block)
      if method.to_s.split(":").length >= 2
        self.send(method.to_s.gsub(":", "_"), *args)
      elsif method == :run
        self.walk(*args)
      else
        super
      end
    end

    private

    def app_name
      @app_name ||= git_config_match[2]
    end

    def domain
      @domain ||= git_config_match[1]
    end

    def git_config_match
      remote = "dokku"
      remote = options[:remote] if options[:remote]

      @git_config_match ||= begin
        git_config = File.join(Dir.pwd, ".git", "config")
        exit unless File.exist?(git_config)

        git_config = File.read(git_config)
        match = git_config.match(/\[remote "#{remote}"\]\n\turl \= dokku@(.*):(.*)\n/).to_a
        exit unless match

        match
      end
    end

    def run_command(command)
      dokku_command = "ssh -t dokku@#{domain} #{command}"

      puts "Running #{dokku_command}..."
      exec(dokku_command)
    end
  end
end
