module DokkuCli
  class Cli < Thor

    desc "events", "Show the last events (-t follows)"
    def events
      run_command "events #{app_name}"
    end

    desc "events:list", "List logged events"
    def events_list
      run_command "events:list #{app_name}"
    end

    desc "events:on", "Enable events logger"
    def events_on
      run_command "events:on #{app_name}"
    end

    desc "events:off", "Disable events logger"
    def events_off
      run_command "events:off #{app_name}"
    end
  end
end
