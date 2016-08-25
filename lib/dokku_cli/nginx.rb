module DokkuCli
  class Cli < Thor

    map "nginx:build" => "nginx_build",
        "nginx:access-logs" => "nginx_access_logs",
        "nginx:error-logs" => "nginx_error_logs"

    desc "nginx:build", "(Re)builds nginx config for the app"
    def nginx_build
      run_command "nginx:build-config #{app_name}"
    end

    desc "nginx:access-logs", "Show the nginx access logs for an application"
    def nginx_access_logs
      run_command "nginx:access-logs #{app_name}"
    end

    desc "nginx:error-logs ", "Show the nginx access logs for an application"
    def nginx_error_logs
      run_command "nginx:error-logs #{app_name}"
    end
  end
end
