  class Nimble::BaseNimble
    # generate nimble headers
    def self.get_headers
     # Arguments:
     #  NIMBLE_API_KEY: (Add this key in your environments development for local)
      headers = {
        "Authorization": "Bearer " + ::Nimble.api_token,
        "Content-Type": 'application/json'
      }
      return headers
    end
    # save data to nimble
    def self.save(nimble_id, data, headers)
      if nimble_id&.present?
        url  = "https://app.nimble.com/api/v1/contact/"+nimble_id+"?replace=1"
        request = ::HTTParty.put(
        url,
        :headers => headers,
        :body => data.to_json
        )
      else
        url  = "https://app.nimble.com/api/v1/contact"
        request = ::HTTParty.post(
        url,
        :headers => headers,
        :body => data.to_json
        )
      end
    end
    # generate json for searching nimble record
    def self.get_find_data(searchable_string, identifier, record)
      fetch = {
       "and": [
         {
           identifier.to_sym => {
             "is": searchable_string
           }
         },
         {
           "record type": {
             "is": record
           }
         }
       ]
     }
     return fetch
    end
    # find nimble record
    def self.find_nimble_record(searchable_string, headers, identifier, record)
      begin
      return nil if (identifier.nil? || searchable_string.nil?)
      data = get_find_data(searchable_string, identifier, record)
      request = ::HTTParty.get(
        "https://app.nimble.com/api/v1/contacts?query="+CGI.escape(data.to_json) +'&tags=0&per_page=5',
        :headers => headers
        )
       value = request["resources"].first["id"]
      rescue
        value = nil
      end
      return value
    end
    # send email for failed instances
    def self.send_status(result = nil, error = nil)
      if result&.success?
        puts 'Data succesfully created'
        return {success: true, result: result, errors: nil}
      else
        puts 'Error occured'
        error_value = result["errors"]&.values&.first&.values&.join(',') if result&.present?
        return {success: false, result: result, errors: error || error_value}
      end
    end
  end