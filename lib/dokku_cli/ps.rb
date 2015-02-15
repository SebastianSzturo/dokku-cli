module DokkuCli
  class Cli < Thor

    desc "ps", "List processes running in app container(s)"
    def ps
      run_command "ps #{app_name}"
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
