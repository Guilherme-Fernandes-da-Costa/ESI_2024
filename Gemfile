source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.1"  # Ou a versão que você usa

gem "rails", "~> 8.0"  # Versão Rails
gem "pg", "~> 1.1"     # Para PostgreSQL (banco recomendado para SaaS)
gem "puma", "~> 6.0"   # Servidor web
gem "bootsnap", ">= 1.4.4", require: false
# Gems para seu projeto: ex. para parsing de proofs
gem "nokogiri"         # Para Regex/HTML parsing
gem "sidekiq"          # Para jobs assíncronos (ex: processamento WhatsApp)

group :development, :test do
  gem "byebug", platforms: [ :mri, :mingw, :x64_mingw ]
end

group :production do
  gem "rails_12factor"  # Para deploy em PaaS como DO
end

group :development, :test do
  gem "rspec-rails"
  gem "cucumber-rails", require: false
  gem "database_cleaner-active_record"
  gem "brakeman" # A partir daqui, gems que os 'checks' julgaram necessarias
  gem "rubocop", require: false
  gem "rubocop-rails-omakase", require: false
  gem "importmap-rails"
end
