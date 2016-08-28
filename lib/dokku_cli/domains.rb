module DokkuCli
  class Cli < Thor

    map "domains:add" => "domains_add",
        "domains:clear" => "domains_clear",
        "domains:remove" => "domains_remove"

    desc "domains", "List custom domains for the app"
    def domains
      run_command "domains #{app_name}"
    end

    desc "domains:add DOMAIN", "Add a custom domain to the app"
    def domains_add(custom_domain)
      run_command "domains:add #{app_name} #{custom_domain}"
    end

    desc "domains:clear","Clear all custom domains for app"
    def domains_clear
      run_command "domains:clear #{app_name}"
    end

    desc "domains:remove DOMAIN", "Remove a custom domain from the app"
    def domains_remove(custom_domain)
      run_command "domains:remove #{app_name} #{custom_domain}"
    end
  end
end
