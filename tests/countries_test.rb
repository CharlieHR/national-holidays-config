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
end
