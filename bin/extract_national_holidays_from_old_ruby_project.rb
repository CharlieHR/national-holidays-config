#!/usr/bin/env ruby

require 'national_holidays'
require 'countries'

holidays = NationalHolidays::Main.new

config_directory = File.expand_path('../conf', __dir__)

Dir.chdir config_directory do
  holidays.countries.countries.each do |country_name|
    country_config = holidays.country(country_name)

    country_name = 'united arab emirates' if country_name == 'dubai'
    country_name.gsub!(/_/, ' ')
    country = ISO3166::Country.find_country_by_name(country_name)
    country_code = country.alpha2.downcase
    local_language_code = country.languages.first

    Dir.mkdir(country_code) unless Dir.exist?(country_code)

    Dir.chdir country_code do
      country_config.regions.each do |region_config|
        config = { 'name' => region_config.region_name }

        region_config.regional_national_holidays.each do |national_holiday|
          year = national_holiday.start_date.year.to_s
          config[year] ||= []
          config[year] << {
            national_holiday.english_name => {
              'public holiday' => true,
              'start_date' => national_holiday.start_date.strftime('%Y-%m-%d'),
              'end_date' => national_holiday.end_date.strftime('%Y-%m-%d'),
              'names' => {
                'en' => national_holiday.english_name,
                local_language_code => national_holiday.local_name
              }
            }
          }
        end

        File.open("#{region_config.region_code}.yml", 'w') do |file|
          file.write(config.to_yaml)
        end
      end
    end
  end
end
