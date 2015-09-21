# Dokku CLI :anchor:

[![Gem Version](https://badge.fury.io/rb/dokku-cli.svg)](http://badge.fury.io/rb/dokku-cli)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/dokku-cli?type=total)](http://badge.fury.io/rb/dokku-cli)

Dokku CLI is a zero config command line tool for the official version of [Dokku](https://github.com/progrium/dokku).

The newest version of Dokku CLI is fully compatible with  ```Dokku 0.4.x```

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
```

## Multiple Remote Apps/Servers (e.g. Staging)

You can use the global option ``--remote`` to run commands on a different server/app from a remote branch. For more details see [heroku's guide](https://devcenter.heroku.com/articles/multiple-environments)  for multiple environments for an app.

```
dokku run rails c --remote staging
```

## All commands

```
$ dokku help
Commands:
  dokku config                                    # Display the app's environment variables
  dokku config:get KEY                            # Display an environment variable value
  dokku config:set KEY1=VALUE1 [KEY2=VALUE2 ...]  # Set one or more environment variables
  dokku config:set:file <path/to/file>            # Set one or more environment variables from file
  dokku config:unset KEY1 [KEY2 ...]              # Unset one or more environment variables
  dokku domains                                   # List custom domains for the app
  dokku domains:add DOMAIN                        # Add a custom domain to the app
  dokku domains:clear                             # Clear all custom domains for app
  dokku domains:remove DOMAIN                     # Remove a custom domain from the app
  dokku help [COMMAND]                            # Describe available commands or one specific command
  dokku logs [-t]                                 # Display logs for the app (-t follows)
  dokku nginx:build                               # (Re)builds nginx config for the app
  dokku open                                      # Open the app in your default browser
  dokku ps                                        # List processes running in app container(s)
  dokku ps:rebuild                                # Rebuild the app
  dokku ps:restart                                # Restart the app container
  dokku ps:start                                  # Start the app container
  dokku run <cmd>                                 # Run a one-off command in the environment of the app
  dokku ssh                                       # Start an SSH session as root user
  dokku url                                       # Show the first URL for the app
  dokku urls                                      # Show all URLs for the app

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dokku-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
