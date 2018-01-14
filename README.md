# Dokku CLI :anchor:

[![Gem Version](https://badge.fury.io/rb/dokku-cli.svg)](http://badge.fury.io/rb/dokku-cli)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/dokku-cli?type=total)](http://badge.fury.io/rb/dokku-cli)

Dokku CLI is a zero config command line tool for the official version of [Dokku](https://github.com/progrium/dokku).

## Installation
```
$ gem install dokku-cli
```

## Usage

Dokku CLI reads the domain of your Dokku server from your git remote called dokku and requires no configuration. Change in your application directory and run ``dokku``


## Remote Commands

```
dokku run <cmd>   # Run a one-off command in the environment of the app
```

## Configuration Management

```
dokku config                                    # Display the app's environment variables
dokku config:get KEY                            # Display an environment variable value
dokku config:set KEY1=VALUE1 [KEY2=VALUE2 ...]  # Set one or more environment variables
dokku config:set:file <path/to/file>            # Set one or more environment variables from file
dokku config:unset KEY1 [KEY2 ...]              # Unset one or more environment variables
```

## Process/Container Management

```
dokku ps           # List processes running in app container(s)
dokku ps:rebuild   # Rebuild the app
dokku ps:restart   # Restart the app container
dokku ps:start     # Start the app container
dokku ps:stop      # Stop the app container
```

## Add SSH key
```
dokku keys:add .ssh/id_rsa.pub Description
```

## Multiple Remote Apps/Servers (e.g. Staging)

You can use the global option ``--remote`` to run commands on a different server/app from a remote branch. For more details see [heroku's guide](https://devcenter.heroku.com/articles/multiple-environments)  for multiple environments for an app.

```
dokku run rails c --remote=staging
dokku config --remote=staging
```

## All commands

```
$ dokku help
Commands:
  dokku certs:add CRT KEY                          # Add an ssl endpoint to an app. Can also import from a tarball on stdin.
  dokku certs:generate DOMAIN                      # Generate a key and certificate signing request (and self-signed certificate)
  dokku certs:info                                 # Show certificate information for an ssl endpoint.
  dokku certs:update CRT KEY                       # Update an SSL Endpoint on an app. Can also import from a tarball on stdin
  dokku config                                     # Display the app's environment variables
  dokku config:get KEY                             # Display an environment variable value
  dokku config:set KEY1=VALUE1 [KEY2=VALUE2 ...]   # Set one or more environment variables
  dokku config:set:file path/to/file               # Set one or more environment variables from file
  dokku config:unset KEY1 [KEY2 ...]               # Unset one or more environment variables
  dokku domains                                    # List custom domains for the app
  dokku domains:add DOMAIN                         # Add a custom domain to the app
  dokku domains:clear                              # Clear all custom domains for app
  dokku domains:remove DOMAIN                      # Remove a custom domain from the app
  dokku events                                     # Show the last events (-t follows)
  dokku events:list                                # List logged events
  dokku events:off                                 # Disable events logger
  dokku events:on                                  # Enable events logger
  dokku help [COMMAND]                             # Describe available commands or one specific command
  dokku keys:add PATH DESCRIPTION                  # Add the ssh key to your dokku machine.
  dokku logs [-n num] [-p ps] [-q quiet [-t tail]  # Display logs for the app
  dokku nginx:access-logs                          # Show the nginx access logs for an application
  dokku nginx:build                                # (Re)builds nginx config for the app
  dokku nginx:error-logs                           # Show the nginx access logs for an application
  dokku open                                       # Open the app in your default browser
  dokku ps                                         # List processes running in app container(s)
  dokku ps:rebuild                                 # Rebuild the app
  dokku ps:restart                                 # Restart the app container
  dokku ps:start                                   # Start the app container
  dokku ps:scale                                   # List the current scale of Procfile processes
  dokku ps:scale proc1=scale1 [proc2=scale2 ...]   # Scale one or more Procfile processes
  dokku run <cmd>                                  # Run a one-off command in the environment of the app
  dokku ssh                                        # Start an SSH session as root user
  dokku url                                        # Show the first URL for the app
  dokku urls                                       # Show all URLs for the app

Options:
  [--remote=REMOTE]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dokku-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
