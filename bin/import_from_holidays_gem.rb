#!/usr/bin/env ruby
# frozen_string_literal: true

require 'holidays'
require 'date'
require 'yaml'
require 'countries'
require 'awesome_print'

class HolidaysGemImporter
  attr_reader :our_file, :holiday_name_language, :holidays_gem_region, :start_year, :end_year

  def initialize(our_file, holiday_name_language, holidays_gem_region, start_year, end_year)
    @our_file = our_file
    @holiday_name_language = holiday_name_language
    @holidays_gem_region = holidays_gem_region.to_sym
    @start_year = start_year.to_i
    @end_year = end_year.to_i
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    data = YAML.safe_load(File.read(our_file))

    start_year.upto(end_year) do |year|
      year_data = []

      holidays = Holidays.between(Date.new(year, 1, 1), Date.new(year, 12, 31), holidays_gem_region)

      holidays.each do |holiday|
        year_data << {
          'public_holiday' => true,
          'date' => holiday[:date].to_s,
          'names' => {
            'en' => holiday[:name],
            holiday_name_language => holiday[:name],
          },
        }
      end

      data['years'][year.to_s] = year_data
    end

    File.write(@our_file,data.to_yaml)
  end
end

unless ARGV.length == 5
  abort "Usage: <our config file> <holiday name language> <holidays gem region> <start_year> <end_year>"
end

our_file, holiday_name_language, holidays_gem_region, start_year, end_year = ARGV

HolidaysGemImporter.call(our_file, holiday_name_language, holidays_gem_region, start_year, end_year)
