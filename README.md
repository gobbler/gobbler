# Gobbler

Access to Gobbler API

_PLEASE NOTE_: This should only be used for testing for now. It's only
an experiement and could rapidly change and break as we work on it.

## Installation

Add this line to your application's Gemfile:

    gem 'gobbler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gobbler

## Development

`Gemfile`

    gem "gobbler", path: "~/src/gobbler"

`api.rb`

    require 'bundler/setup'
    Bundler.require

    Gobbler.config(email: "...", password: "...")

    puts Gobbler::Dashboard.list

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
