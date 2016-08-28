module DokkuCli
  class Cli < Thor

    map "keys:add" => "keys_add"

    desc "keys:add PATH DESCRIPTION", "Add the ssh key to your dokku machine."
    def keys_add(path, description)
      command = "cat #{path} | ssh -p #{port} root@#{domain} 'sudo sshcommand acl-add dokku #{description}'"

      puts "Adding #{path} to your dokku machine..."
      exec(command)
    end
  end
end
