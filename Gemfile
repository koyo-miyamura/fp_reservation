source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Default gems
gem 'rails'       , '~> 5.1.4'
gem 'puma'        , '~> 3.7'
gem 'sass-rails'  , '~> 5.0'
gem 'uglifier'    , '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks'  , '~> 5'
gem 'jbuilder'    , '~> 2.5'

# Add extra gems
gem 'bootstrap-sass'         , '3.3.7'
gem 'bcrypt'                 , '3.1.12'
gem 'jquery-rails'           , '4.3.1'
gem 'faker'                  , '1.7.3'
gem 'will_paginate'          , '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
