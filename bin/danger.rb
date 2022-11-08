#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'yaml'
require 'countries'

class Danger
  def self.run
    new.run
  end

  def run
    Dir.chdir(config_directory) do
      ISO3166::Country.all.sort_by(&:iso_short_name).map do |country|
        check(country)
      end
    end
  end

  private

  def check(country)
    alpha2 = country.alpha2.downcase

    if Dir.exist?(alpha2)
      Dir.chdir(alpha2) do
        Dir.glob('*.yml').sort.map do |filename|
          region_data = YAML.safe_load(File.read(filename))

          region_name = region_data.fetch('name')
          region_years = region_data.fetch('years')

          public_holidays_latest_year = region_years.keys.select do |year|
            region_years[year].any? { |d| d['public_holiday'] }
          end.map(&:to_i).compact.max

          if public_holidays_latest_year <= Date.today.year
            puts "#{country.iso_short_name}\t#{region_name}\t#{public_holidays_latest_year}"
          end
        end
      end
    end
  end

  def config_directory
    File.expand_path('../conf', __dir__)
  end
end

Danger.run
