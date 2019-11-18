# frozen_string_literal: true

require 'minitest/autorun'
require './tests/helper'

describe 'Regions' do
  describe 'must have unique codes across all countries' do
    seen = {}

    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*/*.yml').each do |region_file|
        region_name = region_file.sub(%r{^.+/}, '').sub(/\.yml$/, '')

        it "region #{region_name} for #{region_file} is unique" do
          if seen.key?(region_name)
            flunk "already seen in #{seen[region_name]}!"
          else
            pass
            seen[region_name] = region_file
          end
        end
      end
    end
  end

  describe 'must have clean names' do
    Dir.chdir(TestUtils.config_directory) do
      Dir.glob('*/*.yml').each do |region_file|
        region_name = region_file.sub(%r{^.+/}, '').sub(/\.yml$/, '')

        it "region #{region_name} does not end with a comma" do
          name.wont_match(/,$/)
        end

        it "region #{region_name} does not end with whitespace" do
          name.wont_match(/\s$/)
        end

        it "region #{region_name} does not contain any smart quotes" do
          name.wont_match(/[‘’]/)
        end
      end
    end
  end
end
