# Volt Command

The volt command provides various helpers for managing a project and working with its data.

## new

You can use ```volt new project_name``` to create a new project.  The new command will setup the basic app structure and is the reccomended way to create new projects.

NOTE: volt new is the only command that should be run without ```bundle exec``` in front of it.  Alll other commands should use ```bundle exec```

## generate

The generate command can be used to create code stubs for you.

### model

```bundle exec volt generate model NAME COMPONENT```

NAME is the name of the model you want to generate.  This should be singular.  If COMPONENT is not specified, the ```main``` component is assumed.

Example:

```bundle exec volt generate model item```

### component

```bundle exec volt generate component NAME```

The component generator creates a component for you in ```app```.

Example:

```bundle exec volt generate component blog```

### gem

```bundle exec volt generate gem NAME```

Gem generates the files for a component gem.  Component gems allow you to easily reuse components between projects.

## server

```bundle exec volt server```

Server runs the server on port 3000 by default.

Options:
1.  -p, [--port=the port the server should run on]
2.  -b, [--bind=the ip the server should bind to]

## precompile

TODO: finish docs for precompile

## runner

```bundle exec volt runner path/to/file.rb```

Runner is an easy way to run code inside of the volt environment.  Runner takes the path to a ruby file to be run.

## drop_collection

TODO:...
