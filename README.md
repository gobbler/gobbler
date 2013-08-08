# Gobbler

Access to Gobbler API via Ruby

## Installation

Add this line to your application's Gemfile:

    gem 'gobbler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gobbler

## Documentation

Documentation is available at [rdoc.info](http://rdoc.info/gems/gobbler/frames)

## Exmaple Usage

    require 'gobbler'

    ## Set up authentication and sign in
    Gobbler.config(email: "...", password: "...")

    ## Get the high-level metrics for your account
    puts Gobbler::Dashboard.list

    ## Get a list of all project names
    puts Gobbler.projects.collect(&:name)

    ## Get a list of all files in a project
    project = Gobbler.projects.first
    checkpoint = project.last_checkpoint

    checkpoint.assets.each do |asset|
      puts asset["relative_path"]
    end

    ## Get a list of all machines that you have signed into gobbler with
    puts Gobbler.machines

    ## Get a list of the cities that each of your drives was last seen in
    Gobbler.volumes.each do |volume|
      puts "#{volume.volume_name} : #{volume.city}"
    end
