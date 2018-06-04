# frozen_string_literal: true

require 'minitest/autorun'
require './tests/helper'

describe 'Countries' do
  describe 'must not have any countries which are not ISO 3166-1' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*').each do |country_name|
        it "Has #{country_name} which is ISO 3166-1" do
          ISO3166::Country.new(country_name).alpha2.must_equal country_name.upcase
        end
      end
    end
  end

  describe 'all countries have at least one region' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*').each do |country_name|
        Dir.chdir(country_name) do
          regions = Dir.glob('*.yml')

          if regions.length > 0
            it "#{country_name} has #{regions.length} region#{regions.length > 1 ? 's' : ''} regions" do
              pass
            end
          else
            it "#{country_name} has no regions" do
              flunk
            end
          end
        end
      end
    end
  end

  describe 'all countries have at least one region' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*').each do |country_name|
        Dir.chdir(country_name) do
          regions = Dir.glob('*.yml')

          if regions.length > 0
            it "#{country_name} has #{regions.length} region#{regions.length > 1 ? 's' : ''}" do
              pass
            end
          else
            it "#{country_name} has no regions" do
              flunk
            end
          end
        end
      end
    end
  end
end
