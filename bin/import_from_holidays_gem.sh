#!/bin/bash

set -e
set -x

# Updating existing regions

./bin/import_from_holidays_gem.rb 'conf/ar/argentina01.yml'      'es' 'ar'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/bg/bulgaria01.yml'       'bg' 'bg_bg'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/fr/france03.yml'         'fr' 'fr'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/de/germany15.yml'        'de' 'de_sn'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/de/germany16.yml'        'de' 'de_st'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/im/isle_of_man01.yml'    'en' 'gb_iom' '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/my/malaysia01.yml'       'en' 'my'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/mt/malta01.yml'          'mt' 'mt_mt'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ng/nigeria01.yml'        'en' 'ng'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ph/philippines01.yml'    'en' 'ph'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/sg/singapore01.yml'      'en' 'sg'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/asturias.yml'         'es' 'es_o'   '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/castile-and-leon.yml' 'es' 'es_cl'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/galicia.yml'          'es' 'es_ga'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/spain01.yml'          'es' 'es_m'   '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/spain02.yml'          'es' 'es_ct'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/spain03.yml'          'es' 'es_an'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/spain04.yml'          'es' 'es_vc'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/es/spain07.yml'          'es' 'es_ib'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ch/switzerland01.yml'    'de' 'ch_ge'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ch/zug.yml'              'de' 'ch_zg'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ch/zurich.yml'           'de' 'ch_zh'  '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/th/thailand01.yml'       'th' 'th'     '2021' '2022'
./bin/import_from_holidays_gem.rb 'conf/ve/venezuela01.yml'      'es' 've'     '2021' '2022'

# New regions

./bin/import_from_holidays_gem.rb 'conf/us/united_states52.yml'  'en' 'us'     '2020' '2022'
./bin/import_from_holidays_gem.rb 'conf/ca/canada14.yml'         'en' 'ca'     '2020' '2022'
