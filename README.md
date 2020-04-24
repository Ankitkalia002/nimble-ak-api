# README

To create a person on nimble
Nimble::Person.call(user_attributes, additional_details)

To create a company on nimble
Nimble::Company.call(company_attributes, additional_details)

*attributes available*

user_attributes = {
  first_name: 'first name',
  last_name: 'last name',
  email: 'email',
  title: 'title',
  phone: 'phone',
  parent_company: 'company name',
  avatar_url: 'avatar url'
}

company_attributes = {
  company_name: 'value',
  domain: 'value',
  phone: 'value',
  email: 'value',
  twitter: 'value',
  instagram: 'value',
  facebook: 'value',
  linkedin: 'value'
}

*for existing record*

additional_details = {
  searchable_string: 'value' # to find a nimble record then update if exists, if new record please left this empty
  identifier: 'email' # key on which nimble record will be fetched, values are id, email
  save_on_empty: boolean # will be used to save record if value is present or not
}


NOTE: you can add your custom attributes for contact and company for example:
if you create a field with name - Hello World on nimble use the key here as hello_world

Please add the following to your nimble.rb file inside config/initializers

require 'nimble_api_ak'
Nimble.api_token = TOKEN


