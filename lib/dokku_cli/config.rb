module DokkuCli
  class Cli < Thor

    map "config:get" => "config_get",
        "config:set" => "config_set",
        "config:unset" => "config_unset",
        "config:set:file" => "config_set_file"

    desc "config", "Display the app's environment variables"
    def config
      run_command "config #{app_name}"
    end

    desc "config:get KEY", "Display an environment variable value"
    def config_get(key)
      run_command "config:get #{app_name} #{key}"
    end

    desc "config:set KEY1=VALUE1 [KEY2=VALUE2 ...]", "Set one or more environment variables"
    def config_set(*args)
      # FIXME: Requires root to send config values with spaces
      user = "dokku"

      args = args.map{|arg|
        key_value = arg.split("=")
        if key_value.length == 2
          if key_value[1].index(" ")
            user = "root"
            return_value  = "#{key_value[0]}="
            return_value += '\"'
            return_value += key_value[1].gsub(/"|'/, "")
            return_value += '\"'
            return_value
          else
            "#{key_value[0]}=#{key_value[1].gsub(/"|'/, "")}"
          end
        else
          arg
        end
      }

      command  = "ssh -p #{port} #{user}@#{domain} "
      command += user == "root" ? "dokku " : ""
      command += "config:set #{app_name} #{args.join(' ')}"

      puts "Running #{command}..."
      exec(command)
    end

    desc "config:unset KEY1 [KEY2 ...] ", "Unset one or more environment variables"
    def config_unset(*args)
      run_command "config:unset #{app_name} #{args.join(' ')}"
    end

    desc "config:set:file path/to/file", "Set one or more environment variables from file"
    def config_set_file(config_file)
      config_params = ""
      if File.exists?(config_file)
        File.open(config_file).each_line do |line|
          config_params += line.strip + " " unless line.start_with? "#" || line.strip == ""
        end
        config_set(config_params)
      else
        puts "File #{config_file} does not exist."
      end
    end
  end
end
