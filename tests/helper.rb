# frozen_string_literal: true

require 'countries'

class TestUtils
  def self.config_directory
    File.expand_path('../conf', __dir__)
  end
end
