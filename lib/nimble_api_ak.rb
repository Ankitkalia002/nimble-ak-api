module Nimble
  def self.api_token
    @api_token
  end
  def self.api_token=(token)
    @api_token = token
  end
  require 'httparty'
  require 'nimble/base_nimble'
  require 'nimble/person'
  require 'nimble/company'


end