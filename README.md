# WORK IN PROGRESS, NOT READY FOR USE

Until this is done you can use the [neosepulveda/national_holidays](https://github.com/neosepulveda/national_holidays) Ruby gem that this is based on.

# National holidays config

## A configuration first repository

The value in this repository comes from the conf directory. It is designed to be a technology agnostic set of configuration which can be included into any project no matter what programming language it is written in.

## National Holidays

National holidays configuration is stored in YAML files in a hierarchy: Country > Region > Year > Holiday.

Holidays can be one or more days long, have names in various languages, and can be marked as "public holiday" or not. A public holiday is one where everybody in the region is entitled to the day off from work.

Countries are given as ISO 3166-1 alpha-2 country codes, for example `gb`.

Regions can be given any meaningful name in ASCII, for example `united_kingdom01`.

Languages are given as ISO 639-1 codes, eg. `en`.

## Tests

This repository ships with a test suite written in Ruby using MiniTest. To run the tests:

    $ gem install bundler
    $ bundle install
    $ bundle exec rake test

## Coverage

View the current coverage in [docs/coverage.md](docs/coverage.md).

The repository started out with the configuration from [neosepulveda/national_holidays](https://github.com/neosepulveda/national_holidays) which has 71 countries' public holidays stored inside Ruby code.

## How to contribute

This project is managed with Github. To add a new country or update an existing one, [open a Pull Request](https://github.com/CharlieHR/national-holidays-config/pulls) with your proposed changes.

We have adopted the [Contributor Covenant](https://www.contributor-covenant.org/) as our code of conduct. For full details see [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## Who are we?

We run [CharlieHR](https://www.charliehr.com) where knowing about public and national holidays helps us calculate time off for 1000s of companies.
