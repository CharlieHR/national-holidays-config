#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'yaml'
require 'countries'

class CoverageDoc
  def initialize
    @covered_countries = 0
    @total_countries = 0
  end

  def self.write
    new.write
  end

  def write
    File.open(output_file, 'w') do |file|
      file.write(header + "\n\n")
      file.write(table + "\n\n")
      file.write(footer + "\n")
    end
  end

  private

  def header
    [].tap do |header|
      header << '# Coverage'
      header << "Last updated #{Date.today}."
    end.join("\n\n")
  end

  def footer
    "Total coverage: #{@covered_countries} / #{@total_countries}"
  end

  def table
    table_data.map { |a| "| #{a.join(' | ')} |" }.join("\n")
  end

  def table_header
    [
      'Flag',
      'Country',
      'Region',
      'Latest Public Holidays Year',
      'Known Public Holidays',
      'Latest Non-public Holidays Year',
      'Known Non-public Holidays'
    ]
  end

  def table_data
    [].tap do |table|
      table << table_header

      table << table.first.map { |s| s.gsub(/./, '-') }

      Dir.chdir(config_directory) do
        ISO3166::Country.all.sort_by(&:iso_short_name).map do |country|
          country_rows(country).each do |row|
            table << row
          end
        end
      end
    end
  end

  def country_rows(country)
    @total_countries += 1
    alpha2 = country.alpha2.downcase

    if Dir.exist?(alpha2)
      @covered_countries += 1
      Dir.chdir(alpha2) do
        Dir.glob('*.yml').sort.map do |filename|
          region_data = YAML.safe_load(File.read(filename))

          region_name = region_data.fetch('name')
          region_years = region_data.fetch('years')

          public_holidays_latest_year = region_years.keys.select do |year|
            region_years[year].any? { |d| d['public_holiday'] }
          end.map(&:to_i).compact.max&.to_s

          non_public_holidays_latest_year = region_years.keys.select do |year|
            region_years[year].any? { |d| !d['public_holiday'] }
          end.map(&:to_i).compact.max&.to_s

          [
            country.emoji_flag,
            country.iso_short_name,
            region_name,
            public_holidays_latest_year || '-',
            public_holidays_latest_year ? region_years[public_holidays_latest_year].count : '-',
            non_public_holidays_latest_year || '-',
            non_public_holidays_latest_year ? region_years[non_public_holidays_latest_year].count : '-'
          ]
        end
      end
    else
      [
        [country.emoji_flag, country.iso_short_name, 'No Data', '-', '-', '-', '-']
      ]
    end
  end

  def config_directory
    File.expand_path('../conf', __dir__)
  end

  def output_file
    File.expand_path('../docs/coverage.md', __dir__)
  end
end

CoverageDoc.write
