require 'thor'

require "dokku_cli/version"
require "dokku_cli/config"
require "dokku_cli/domains"
require "dokku_cli/nginx"
require "dokku_cli/ps"
require "dokku_cli/events"
require "dokku_cli/certs"
require "dokku_cli/keys"

module DokkuCli
  class Cli < Thor
    class_option :remote

    desc "logs [-n num] [-p ps] [-q quiet [-t tail]", "Display logs for the app"
    method_option :n, type: :numeric, aliases: %w{-num --num},
      desc: "Limit to <n> number of lines"
    method_option :p, type: :string, aliases: %w{-ps --ps},
      desc: "Filter by <p> process"
    method_option :q, type: :boolean, aliases: %w{-quiet --quiet},
      desc: "Remove docker prefixes from output"
    method_option :t, type: :boolean, aliases: %w{-tail --tail},
      desc: "Follow output"
    def logs
      args = options.map{|k, v| "-#{k} #{v}"}.join(" ")
      if args.empty?
        run_command "logs #{app_name}"
      else
        # remove unnecessary mapped remote option
        args = args.gsub(/-remote [\S]*/, '')
        command = "ssh -t -p #{port} dokku@#{domain} logs #{app_name} #{args}"
        puts "Running #{command}..."
        exec(command)
      end
    end

    desc "open", "Open the app in your default browser"
    def open
      url = %x[dokku urls --remote #{app_name}].split("\r").first
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
    map "run" => "walk"

    desc "ssh", "Start an SSH session as root user"
    def ssh
      command = "ssh -p #{port} root@#{domain}"
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

    private

    def app_name
      @app_name ||= git_config["app_name"]
    end

    def domain
      @domain ||= git_config["domain"]
    end

    def port
      @port ||= git_config["port"]
    end

    def git_config
      remote = "dokku"
      remote = options[:remote] if options[:remote]

      @git_config ||= begin
        config_path = File.join(Dir.pwd, ".git", "config")
        exit unless File.exist?(config_path)
        config_file = File.read(config_path)

        # Default dokku config: dokku@host.com:app
        default_style_regex = /\[remote "#{remote}"\]\s+url \= dokku@(?<domain>.*):(?<app_name>.*)$/
        match ||= config_file.match(default_style_regex)

        # SSH dokku config: ssh://dokku@host.com:1337/app
        ssh_style_regex = /\[remote "#{remote}"\]\s+url \= ssh:\/\/dokku@(?<domain>.*):(?<port>.*)\/(?<app_name>.*)$/
        match ||= config_file.match(ssh_style_regex)

        exit unless match
        match = Hash[match.names.zip(match.captures)]
        match["port"] ||= 22

        match
      end
    end

    def run_command(command)
      command = command.gsub(/ --remote=[\S]*/, '')
      dokku_command = "ssh -t -p #{port} dokku@#{domain} #{command}"

      puts "Running #{dokku_command}..."
      exec(dokku_command)
    end
  end
end
