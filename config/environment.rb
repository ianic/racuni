# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '1.2.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below


# Disable Auto Table Name Pluralisation
ActiveRecord::Base.pluralize_table_names = false

# hrvatsko formatiranje datum
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(:hr=> '%d.%m.%y')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :default => "%d.%m.%y",
  :date_time12 => "%m/%d/%Y %I:%M%p",
  :date_time24 => "%m/%d/%Y %H:%M"
)


# unicode UTF-8 podrĹˇka
$KCODE = 'u'
require 'jcode'

#ActionView::Base.erb_trim_mode = '%>'

Inflector.inflections do |inflect|
  inflect.irregular 'partner', 'partneri'
  
  inflect.irregular 'racun', 'racuni'
  inflect.irregular 'gotovinski_racun', 'gotovinski_racuni'
  inflect.irregular 'ulazni_racun', 'ulazni_racuni'
  inflect.irregular 'ponuda', 'ponude'
  
  inflect.irregular 'izvod', 'izvodi'
  
  inflect.irregular 'izdatak', 'izdaci'
  inflect.irregular 'primitak', 'primici'
  inflect.irregular 'stavka', 'stavke'
  
  inflect.irregular 'racun_placanje', 'racuni_placanja'
  inflect.irregular 'ulazni_racun_placanje', 'ulazni_racuni_placanja'
end