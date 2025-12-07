source "https://rubygems.org"

ruby "~> 3.3.3"

# Rails
gem "rails", "~> 7.1.3"

# Asset pipeline
gem "sprockets-rails"

# ---- DATABASES -------------------------------------------------
# SQLite apenas em desenvolvimento local (não no CI)
gem "sqlite3", "~> 1.4", group: :development

# PostgreSQL em produção **e** em teste (CI)
group :production, :test do
  gem "pg", "~> 1.5"
end
# ---------------------------------------------------------------

gem "puma", ">= 5.0"

# JS / Hotwire
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

gem "jbuilder"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

gem 'bcrypt', '~> 3.1.7'
# GRUPO DE PRODUÇÃO (PARA O HEROKU)
group :production do
  gem "pg"
end

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]

  # ---- TEST FRAMEWORKS ----
  gem "rspec-rails"
  gem "rspec"
  gem "factory_bot_rails"
  gem "cucumber-rails", require: false
  gem "capybara"
  gem "database_cleaner-active_record"

  # ---- COBERTURA ----
  gem "simplecov", require: false
  gem "coveralls", require: false
  gem 'shoulda-matchers', '~> 5.0'

  #gem 'rails-controller-testing'
  #gem 'faker' # opcional, mas útil para dados de teste
end

group :development do
  gem "web-console"
end

# ---------- TESTES E2E ----------
group :test do
  gem "selenium-webdriver"
  # (capybara já está no grupo acima)
end
