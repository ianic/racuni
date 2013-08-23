# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Racuni::Application.initialize!

# Disable Auto Table Name Pluralisation
ActiveRecord::Base.pluralize_table_names = false

# hrvatsko formatiranje datum
Date::DATE_FORMATS.merge!(:hr=> '%d.%m.%y')
Time::DATE_FORMATS.merge!(
                          :default => "%d.%m.%y",
                          :date_time12 => "%m/%d/%Y %I:%M%p",
                          :date_time24 => "%m/%d/%Y %H:%M"
                          )

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
