
  # frozen_string_literal: true
  class Nimble::Company < Nimble::BaseNimble
    # MAX_RETRIES = 3
    RECORD_IS = 'company'
    # CALLING METHOD
    def self.call(company_attributes, additional_details = nil)
      # intialize retries
      return nil unless company_attributes.class == Hash
      retiries_count = 0
      begin
        # fetch headers
        headers = get_headers
        # find nimble id if exists
        if (additional_details.nil? || additional_details.class != Hash)
          additional_details = {
            save_on_empty: true,
            searchable_string: "",
            identifier: nil
          }
        end
        nimble_id = find_nimble_record(additional_details[:searchable_string], headers, additional_details[:identifier], Nimble::Company::RECORD_IS)
        # create json data
        data = get_save_data(company_attributes, additional_details[:save_on_empty])
        # save data on nimble
        result = save(nimble_id, data, headers)
        # send email based on response
        send_status(result)
      rescue => e
        # display error message
        puts e.message
        # increment retry count
        # retiries_count +=1
        # if Nimble::Company::MAX_RETRIES >= retiries_count
        #   # max upto 3 retries
        #   retry
        # else
          # send failed email
          send_status(nil, e.message)
        # end
      end
    end

    def self.get_save_data(company_attributes, save_on_empty)
      # parent json
      company_json = {
        "fields": {
        },
        "record_type": "company"

      }

      company_attributes.each {
        |key, value|
        field = {
          key&.to_s.gsub('_', ' ').to_sym => [
            {
              "value": value,
              "modifier": ""
            }
          ]
        }
        if save_on_empty
          company_json[:fields] = company_json[:fields].merge(field)
        else
          company_json[:fields] = company_json[:fields].merge(field) if value&.present?
        end
        field = {}
      }
      return company_json
    end
  end