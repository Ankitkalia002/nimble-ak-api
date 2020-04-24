
  # frozen_string_literal: true
  class Nimble::Person < Nimble::BaseNimble
    MAX_RETRIES = 3
    RECORD_IS = 'person'
    def self.call(user_attributes, additional_details = nil)
      retiries_count = 0
      return nil unless user_attributes.class == Hash
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
        nimble_id = find_nimble_record(additional_details[:searchable_string], headers, additional_details[:identifier], Nimble::Person::RECORD_IS)
        # create json data
        data = get_save_data(user_attributes, additional_details[:save_on_empty])
        # save data on nimble
        result = save(nimble_id, data, headers)
        # send email based on response
        send_status(result)
      rescue => e
        # display error message
        puts e.message
        # increment retry count
        retiries_count +=1
        if Nimble::Person::MAX_RETRIES >= retiries_count
          # max upto 3 retries
          retry
        else
          # send failed email
          send_status(nil, e.message)
        end
      end
    end

    def self.get_save_data(user_attributes, save_on_empty)
      # parent json

      person_json = {
        "fields": {
        },
        "record_type": "person"

      }

      user_attributes.each {
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
          person_json[:fields] = person_json[:fields].merge(field) unless key == 'user_avatar'
        else
          unless key == 'user_avatar'
            person_json[:fields] = person_json[:fields].merge(field) if value&.present?
          end
        end
        field = {}
      }
      # avatar json
      if user_attributes[:user_avatar]&.present?
        avatar = {
          "avatar_url": user_attributes[:user_avatar]
        }
        person_json = person_json.merge(avatar)
      end
      # merge all json in parent based on existence
      return person_json
    end
  end