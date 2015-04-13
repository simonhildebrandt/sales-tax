require 'ostruct'

module BasketParser
  class << self
    def parse_data(input)
      input.readlines[1..-1].collect do |line|
        fields = line.split(', ')
        OpenStruct.new(quantity: fields[0].to_i, product: fields[1], price: fields[2].strip)
      end
    end
  end
end
