module DokkuCli
  class Cli < Thor

    map "ps:rebuild" => "ps_rebuild",
        "ps:restart" => "ps_restart",
        "ps:start" => "ps_start"

    desc "ps", "List processes running in app container(s)"
    def ps
      run_command "ps #{app_name}"
    end

    desc "ps:scale PROC1=SCALE1 [PROC2=SCALE2 ...]", "Scale one or more Procfile processes"
    def ps_scale(*args)

      args.map! do |arg|
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
      end

      run_command "ps:scale #{app_name} #{args.join " "}"
    end

    desc "ps:rebuild", "Rebuild the app"
    def ps_rebuild
      run_command "ps:rebuild #{app_name}"
    end

    desc "ps:restart", "Restart the app container"
    def ps_restart
      run_command "ps:restart #{app_name}"
    end

    desc "ps:start", "Start the app container"
    def ps_start
      run_command "ps:start #{app_name}"
    end
  end
end
