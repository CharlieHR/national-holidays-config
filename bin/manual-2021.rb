#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'yaml'
require 'countries'

class DataParser
  DATA = <<~__END__
    bh	bahrain01
    01/01/2021	New Years Day
    01/05/2021	Labour Day
    13/05/2021	Eid al-Fitr
    14/05/2021	Eid al-Fitr holiday
    15/05/2021	Eid al-Fitr holiday
    20/07/2021	Eid al adha
    21/07/2021	Eid al adha holiday
    22/07/2021	Eid al adha holiday
    09/08/2021	Al Hijra New Year
    17/08/2021	Ashoora
    18/08/2021	Ashoora
    18/10/2021	Prophet's birthday
    16/12/2021	Bahrain National Day
    17/12/2021	Bahrain National Day

    by	belarus01
    01/01/2021	New Years Day
    07/01/2021	Orthodox Christmas Day
    08/03/2021	International Women's day
    01/05/2021	Labour Day
    09/05/2021	Victory Day
    11/05/2021	Radonitsa
    03/07/2021	Independance Day
    07/11/2021	October Revolution Day
    25/12/2021	Catholic Christmas Day

    et	ethiopia01
    07/01/2021	Ethiopian Christmas
    19/01/2021	Timket
    02/03/2021	Adwa Victory Day
    30/04/2021	Siklet
    01/05/2021	Labour Day
    02/05/2021	Ethiopian Easter Sunday
    05/05/2021	Patriot's Victory Day
    13/05/2021	Eid al-Fitr
    28/05/2021	Derg Downfall Day
    20/07/2021	Eid al-Adha
    11/07/2021	Ethiopian New Year
    27/07/2021	Mescal
    19/10/2021	Prophet Muhammad's Birthday

    gi	gibraltar01
    01/01/2021	New Years Day
    15/02/2021	Commonwealth Day
    02/04/2021	Good Friday
    05/04/2021	Easter Monday
    28/04/2021	Workers Memorial Day
    03/05/2021	May Day
    31/05/2021	Spring Bank Holiday
    14/06/2021	Queen's Birthday
    30/08/2021	Late Summer Bank Holiday
    10/09/2021	National Day
    27/12/2021	Christmas Day
    28/12/2021	Boxing Day

    gr	greece01
    01/01/2021	New Years Day
    06/01/2021	Ephiphany
    15/03/2021	Orthodox Ash Wednesday
    25/03/2021	Independance Day
    30/04/2021	Orthodox Good Friday
    01/05/2021	Labour Day
    02/05/2021	Orthodox Easter Sunday
    03/05/2021	Orthodox Easter Monday
    20/06/2021	Orthodox Whit Sunday
    21/06/2021	Orthodox Whit Monday
    15/08/2021	Assumption Day
    28/10/2021	Ochi Day
    25/12/2021	Christmas Day
    26/12/2021	2nd Day of Chrismas

    ht	haiti01
    01/01/2021	Independance Day
    02/01/2021	Founder's Day
    16/02/2021	Carnival
    17/02/2021	Ash Wednesday
    02/04/2021	Good Friday
    01/05/2021	Labour and Agricultural Day
    18/05/2021	Flag and University day
    03/07/2021	Corpus Christi
    15/08/2021	Assumption Day
    17/10/2021	Death of Dessalines
    01/11/2021	All Saint's Day
    02/11/2021	All Soul's Day
    18/11/2021	Battle of Vertieres
    25/12/2021	Christmas Day

    id	indonesia01
    01/01/2021	New Years Day
    12/02/2021	Chinese New Year
    11/03/2021	Isra Mi'raj
    12/03/2021	Isra Mi'raj Holiday
    14/03/2021	Bali Hindu New Year
    02/04/2021	Good Friday
    01/05/2021	Labour Day
    12/05/2021	Lebehan Day
    13/05/2021	Ascention Day of Jesus
    14/05/2021	Hari Raya Idul Fitri
    17/05/2021	Lebehan Holiday
    18/05/2021	Lebehan Holiday
    19/05/2021	Lebehan Holiday
    26/05/2021	Waisak Day
    01/06/2021	Pancasila Day
    20/07/2021	Idul Adha
    10/08/2021	Islamic New Year
    17/08/2021	Independance Day
    19/10/2021	Prophet Muhammad's Birthday
    24/12/2021	Christmas Holiday
    25/12/2021	Christmas Day
    27/12/2021	Christmas Holiday

    ir	iran01
    29/01/2021	Martyrdom of Hazrat Fatemah
    11/02/2021	Anniversary of the Islamic Revolution
    08/03/2021	Birthday of Imam Ali
    19/03/2021	Oil Nationalization Day
    20/03/2021	Novrus Holiday
    21/03/2021	Novrus Holiday
    22/03/2021	Mabaath
    23/03/2021	Novrus Holiday
    31/03/2021	Islamic Republic Day
    01/04/2021	Sizdah Bedar
    09/04/2021	Birthday of Imam Mahdi
    15/05/2021	Martyrdom of Imam Ali
    24/05/2021	Eid al-Fitr
    25/05/2021	Eid al-Fitr Holiday
    03/06/2021	Demise of Imam Khomeini
    04/06/2021	Khordad National Uprising (1963)
    17/04/2021	Martyrdom of Imam Sadeq
    31/07/2021	Eid al-Adha
    08/08/2021	Eid al-Ghadir
    29/08/2021	Tassoua
    30/08/2021	Ashura
    08/10/2021	Arbaeen
    16/10/2021	Death of Prophet Muhammad
    17/10/2021	Martyrdom of Imam Reza
    25/10/2021	Martyrdom of Imam Hassan Asgari
    03/11/2021	Prophet Muhammad's Birthday

    jo	jordan01
    01/01/2021	New Years Day
    04/04/2021	Easter Sunday
    05/04/2021	Easter Monday
    01/05/2021	Labour Day
    12/05/2021	Eid al-Fitr Holiday
    13/05/2021	Eid al-Fitr Holiday
    14/05/2021	Eid al-Fitr Holiday
    25/05/2021	Independance Day
    19/07/2021	Eid al-Adha Holiday
    20/07/2021	Eid al-Adha Holiday
    21/07/2021	Eid al-Adha Holiday
    22/07/2021	Eid al-Adha Holiday
    09/08/2021	Islamic New Year
    18/10/2021	Prophet Muhammad's Birthday
    25/12/2021	Christmas Day

    kw	kuwait01
    01/01/2021	New Years Day
    25/02/2021	National Day
    26/02/2021	Liberation Day
    11/03/2021	The Prophet's Ascention
    13/05/2021	Eid al-Fitr
    14/05/2021	Eid al-Fitr Holiday
    15/05/2021	Eid al-Fitr Holiday
    20/07/2021	Eid al-Adha
    21/07/2021	Eid al-Adha Holiday
    09/08/2021	Islamic New Year
    19/10/2021	Prophet Muhammad's Birthday

    mk	macedonia01
    01/01/2021	New Years Day
    07/01/2021	Orthodox Christmas Day
    01/05/2021	Labour Day
    03/05/2021	Orthodox Easter Monday
    13/05/2021	Ramazan Bajram
    24/05/2021	St Cyril and St Methodius Day
    02/08/2021	Republic Day
    08/09/2021	Independance Day
    11/10/2021	Revolution day
    23/10/2021	Day of the Macedonian Revolution
    08/12/2021	Saint Clement of Ohrid Day

    mu	mauritius01
    01/01/2021	New Year's Day
    02/01/2021	New Year's Holiday
    28/01/2021	Thaipoosam Cavadee
    01/02/2021	Abolition of Slavery
    12/02/2021	Chinese Spring Festival
    11/03/2021	Maha Shivaratree
    12/03/2021	Independence and Republic Day
    13/04/2021	Ougadi
    01/05/2021	Labour Day
    14/05/2021	Eid-Ul-Fitr
    11/09/2021	Ganesh Chaturthi
    01/11/2021	All Saints' Day
    02/11/2021	Arrival of Indentured Labourers
    04/11/2021	Diwali
    25/11/2021	Christmas Day

    md	moldova01
    01/01/2021	New Year's Day
    07/01/2021	Orthodox Christmas Day
    08/01/2021	Orthodox Christmas Holiday
    08/03/2021	International Women's Day
    01/05/2021	Labour Day
    02/05/2021	Orthodox Easter Sunday
    03/05/2021	Orthodox Easter Monday
    09/05/2021	Victory Day
    10/05/2021	Easter of Blajini
    01/06/2021	Childern's Day
    27/08/2021	Independence Day
    31/08/2021	National Language Day
    25/12/2021	Christmas Day

    mc	monaco01
    01/01/2021	New Year's Day
    27/01/2021	Saint Dévote's Day
    05/04/2021	Easter Monday
    01/05/2021	Labour Day
    13/05/2021	Ascension Day
    24/05/2021	Whit Monday
    03/06/2021	Corpus Christi
    15/08/2021	Assumption Day
    01/11/2021	All Saints' Day
    19/11/2021	National Day
    08/12/2021	Immaculate Conception
    25/12/2021	Christmas Day

    om	oman01
    11/03/2021	Isra'a Wal Mi'raj
    13/05/2021	Eid al-Fitr Holiday
    14/05/2021	Eid al-Fitr Holiday
    15/05/2021	Eid al-Fitr Holiday
    16/05/2021	Eid al-Fitr Holiday
    20/07/2021	Eid al-Adha Holiday
    21/07/2021	Eid al-Adha Holiday
    22/07/2021	Eid al-Adha Holiday
    23/07/2021	Eid al-Adha Holiday
    23/07/2021	Renaissance Day
    09/08/2021	Islamic New Year
    18/10/2021	Prophet Muhammad's Birthday
    18/11/2021	National Day

    pk	pakistan01
    05/02/2021	Kashmir Day
    23/03/2021	Pakistan Day
    01/05/2021	Labour Day
    13/05/2021	Eid ul-Fitr
    14/05/2021	Eid ul-Fitr Holiday
    15/05/2021	Eid ul-Fitr Holiday
    20/07/2021	Eid ul-Azha
    21/07/2021	Eid ul-Azha Holiday
    14/08/2021	Independence Day
    18/08/2021	Ashura
    19/08/2021	Ashura
    19/10/2021	Milad un-Nabi
    25/12/2021	Christmas Day
    25/12/2021	Quiad-e-Azam Day

    lc	saint_lucia01
    01/01/2021	New Year's Day
    02/01/2021	New Year Holiday
    22/02/2021	Independence Day
    02/04/2021	Good Friday
    05/04/2021	Easter Monday
    01/05/2021	Labour Day
    24/05/2021	Whit Monday
    03/06/2021	Corpus Christi
    01/08/2021	Emancipation Day
    04/10/2021	Thanksgiving Day
    13/12/2021	National Day
    25/12/2021	Christmas Day
    26/12/2021	Christmas Holiday

    sa	saudi_arabia01
    13/05/2021	Eid Al Fitr
    14/05/2021	Eid Al Fitr
    15/05/2021	Eid Al Fitr
    16/05/2021	Eid Al Fitr
    19/07/2021	Arafat Day
    20/07/2021	Eid al-Adha
    21/07/2021	Eid al-Adha
    22/07/2021	Eid al-Adha
    23/09/2021	Saudi National Day

    es	spain05
    01/01/2021	New Year	Año Nuevo
    06/01/2021	Three Kings	La Epifanía del Señor
    01/03/2021	Andalucia Day	El día de Andalucia
    01/04/2021	Maundy Thursday	La festividad del Jueves Santo
    02/04/2021	Good Friday	El Viernes Santo
    01/05/2021	May Day	La Fiesta Nacional del Trabajo
    16/08/2021	Asuncion Day	La Asunción de la Virgen
    12/10/2021	Hispanic Day	La Fiesta Nacional de España
    01/11/2021	All Saints Day	El día de Todos los Santos
    06/12/2021	Constitution Day	El día de la constitución
    08/12/2021	Day of the Immaculate Conception	El día de la Inmaculada Concepción
    25/12/2021	Christmas Day	El día de Navidad

    es	spain06
    01/01/2021	New Year's Day
    06/01/2021	Epiphany
    19/03/2021	St. Joseph's Day
    09/04/2021	Holy Thursday
    10/04/2021	Good Friday
    13/04/2021	Easter Monday
    01/05/2021	Labour Day
    15/08/2021	Assumption of the Virgin
    12/10/2021	Hispanic Day
    01/11/2021	All Saints Day
    06/12/2021	Constitution Day
    08/12/2021	Immaculate Conception Day
    25/12/2021	Christmas Day

    ae	dubai01
    01/01/2021	New Year's Day
    11/05/2021	Eid al-Fitr Holiday
    12/05/2021	Eid al-Fitr Holiday
    13/05/2021	Eid al-Fitr
    14/05/2021	Eid al-Fitr Holiday
    15/05/2021	Eid al-Fitr Holiday
    19/07/2021	Arafat Day
    20/07/2021	Eid al-Adha
    21/07/2021	Eid al-Adha Holiday
    22/07/2021	Eid al-Adha Holiday
    12/08/2021	Islamic New Year
    21/10/2021	Prophet Muhammad's Birthday
    01/12/2021	Commemoration Day
    02/12/2021	National Day
    03/12/2021	National Day Holiday

    ae	united_arab_emirates01
    01/01/2021	New Year's Day
    11/05/2021	Eid al-Fitr Holiday
    12/05/2021	Eid al-Fitr Holiday
    13/05/2021	Eid al-Fitr
    14/05/2021	Eid al-Fitr Holiday
    15/05/2021	Eid al-Fitr Holiday
    19/07/2021	Arafat Day
    20/07/2021	Eid al-Adha
    21/07/2021	Eid al-Adha Holiday
    22/07/2021	Eid al-Adha Holiday
    12/08/2021	Islamic New Year
    21/10/2021	Prophet Muhammad's Birthday
    01/12/2021	Commemoration Day
    02/12/2021	National Day
    03/12/2021	National Day Holiday

    vn	vietnam01
    01/01/2021	New Year's Day
    10/02/2021	Tet
    11/02/2021	Tet
    12/02/2021	Tet
    13/02/2021	Tet
    14/02/2021	Tet
    15/02/2021	Tet
    16/02/2021	Tet
    21/04/2021	Hung Kings Commemoration Day
    30/04/2021	Reunification Day
    01/05/2021	Labor Day
    03/05/2021	Labor Day Holiday
    02/09/2021	National Day
    03/09/2021	National Day Holiday
  __END__

  def self.data
    return @data if defined?(@data)

    @data = {}

    current_country = nil
    current_region = nil
    DATA.each_line do |line|
      line.chomp!

      if current_country.nil?
        current_country, current_region = line.split(/\t/)

        @data[current_country] ||= {}
        @data[current_country][current_region] = []
      elsif line.empty?
        current_country = nil
      else
        date, name = line.split(/\t/)

        @data[current_country][current_region] << {
          name: name,
          date: Date.parse(date),
        }
      end
    end

    @data
  end
end

class DataImporter
  attr_reader :country, :region, :holidays

  def initialize(country, region, holidays)
    @country = country
    @region = region
    @holidays = holidays
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    data = YAML.safe_load(File.read(file))

    seen = {}

    holidays.each do |holiday|
      year = holiday[:date].year.to_s

      data['years'][year] = [] unless seen[year]
      seen[year] = true

      data['years'][year] << {
        'public_holiday' => true,
        'date' => holiday[:date].to_s,
        'names' => {
          'en' => holiday[:name],
        },
      }
    end

    File.write(file, data.to_yaml)
  end

  private

  def file
    "conf/#{country}/#{region}.yml"
  end
end

DataParser.data.each do |country, country_data|
  country_data.each do |region, holidays|
    DataImporter.call(country, region, holidays)
  end
end
