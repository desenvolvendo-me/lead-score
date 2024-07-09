require 'json'

class WeightValidator
  def self.valid_structure?(json_data)
    begin
      data = JSON.parse(json_data)
    rescue JSON::ParserError => e
      puts "JSON::ParserError: #{e.message}"
      return false
    end

    unless data.is_a?(Hash)
      puts "Data is not a Hash: #{data.class}"
      return false
    end

    data.each do |key, value|
      unless key.is_a?(String) && value.is_a?(Hash)
        puts "Invalid key or value: key = #{key} (#{key.class}), value = #{value} (#{value.class})"
        return false
      end

      value.each do |inner_key, inner_value|
        unless inner_key.is_a?(String) && inner_value.is_a?(Numeric)
          puts "Invalid inner key or value: inner_key = #{inner_key} (#{inner_key.class}), inner_value = #{inner_value} (#{inner_value.class})"
          return false
        end
      end
    end

    true
  end
end
