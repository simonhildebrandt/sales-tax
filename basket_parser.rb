require 'ostruct'

module BasketParser
  class << self
    def parse_file(path)
      open(path).readlines[1..-1].collect do |line|
        fields = line.split(', ')
        OpenStruct.new(quantity: fields[0].to_i, product: fields[1], price: fields[2].strip.to_f)
      end
    end
  end
end
