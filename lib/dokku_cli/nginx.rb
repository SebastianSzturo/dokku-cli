module DokkuCli
  class Cli < Thor

    desc "nginx:build", "(Re)builds nginx config for the app"
    def nginx_build
      run_command "nginx:build-config #{app_name}"
    end
  end
end
