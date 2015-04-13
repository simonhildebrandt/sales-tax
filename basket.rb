require 'ostruct'
require_relative 'basket_parser'
require_relative 'taxable'

class Basket

  def parse_data(data)
    @items = BasketParser.parse_data(data).collect do |item_data|
      Item.new(item_data)
    end
  end

  def print_receipt
    items.collect(&:to_s).join("\n") +
      "\nSales Taxes: #{'%.2f' % total_tax}\nTotal: #{'%.2f' % total_price}"
  end

  def items
    @items
  end

  def total_tax
    sum(items.collect(&:total_tax))
  end

  def total_price
    sum(items.collect(&:total_price))
  end

  def sum(list)
    list.reduce(:+)
  end

  class Item < OpenStruct
    include Taxable

    def to_s
      "#{quantity}, #{product}, #{price}"
    end

    def total_price
      shelf_price + total_tax
    end

    def exempt_from(tax)
      send('exempt_from_' + tax.to_s)
    end

    def exempt_from_sales_tax
      # Ugly hack for guessing sales tax category
      product.match(/\A(book|chocolate bar|imported box of chocolates|box of imported chocolates|packet of headache pills)\z/)
    end

    def exempt_from_import_duty
      !product.match(/imported/)
    end
  end
end
