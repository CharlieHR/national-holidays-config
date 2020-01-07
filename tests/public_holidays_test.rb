# frozen_string_literal: true

require 'minitest/autorun'
require './tests/helper'

require 'date'

describe 'Public Holidays' do
  describe 'must have a valid date' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*/*.yml').each do |region_file|
        region_data = YAML.safe_load(File.read(region_file))

        region_name = region_data['name']

        region_data['years'].each do |year, holidays|
          holidays.each do |holiday|
            it "region #{region_name} holiday #{holiday['names'].values.first} has a valid date" do
              date = begin
                       Date.parse(holiday['date'])
                     rescue ArgumentError
                       nil
                     end
              date&.strftime('%Y-%m-%d').must_equal holiday['date']
            end
          end
        end
      end
    end
  end

  describe 'must occur within the year that they are under' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*/*.yml').each do |region_file|
        region_data = YAML.safe_load(File.read(region_file))

        region_name = region_data['name']

        region_data['years'].each do |year, holidays|
          holidays.each do |holiday|
            it "region #{region_name} holiday #{holiday['names'].values.first} in #{year} is in #{year}" do
              holiday['date'].must_match(/^#{year}-[0-9]{2}-[0-9]{2}$/)
            end
          end
        end
      end
    end
  end

  describe 'must have clean names' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*/*.yml').each do |region_file|
        region_data = YAML.safe_load(File.read(region_file))

        region_name = region_data['name']

        region_data['years'].values.each do |holidays|
          holidays.each do |holiday|
            holiday['names'].values.each do |name|
              it "region #{region_name} holiday #{name} does not end with a comma" do
                name.wont_match(/,$/)
              end

              it "region #{region_name} holiday #{name} does not end with whitespace" do
                name.wont_match(/\s$/)
              end

              it "region #{region_name} holiday #{name} does not contain any smart quotes" do
                name.wont_match(/[‘’]/)
              end

              it "region #{region_name} holiday has a name" do
                name.must_match(/\S+/)
              end
            end
          end
        end
      end
    end
  end
end
