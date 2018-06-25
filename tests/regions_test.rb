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
end
