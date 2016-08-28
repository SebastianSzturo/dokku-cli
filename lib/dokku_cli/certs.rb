module DokkuCli
  class Cli < Thor

    map "certs:add" => "certs_add",
        "certs:generate" => "certs_generate",
        "certs:info" => "certs_info",
        "certs:remove" => "certs_remove",
        "certs:update" => "certs_update"

    desc "certs:add CRT KEY", "Add an ssl endpoint to an app. Can also import from a tarball on stdin."
    def certs_add(crt, key)
      run_command "certs:add #{app_name} #{crt} #{key}"
    end

    desc "certs:generate DOMAIN", "Generate a key and certificate signing request (and self-signed certificate)"
    def certs_generate(domain)
      run_command "certs:generate #{app_name} #{domain}"
    end

    desc "certs:info", "Show certificate information for an ssl endpoint."
    def certs_info
      run_command "certs:info #{app_name}"
    end

    desc "certs:remove", "Remove an SSL Endpoint from an app."
    def certs_remove
      run_command "certs:remove #{app_name}"
    end

    desc "certs:update CRT KEY", "Update an SSL Endpoint on an app. Can also import from a tarball on stdin"
    def certs_update(crt, key)
      run_command "certs:update #{app_name} #{crt} #{key}"
    end
  end
end
