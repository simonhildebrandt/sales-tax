require 'bigdecimal'
require 'bigdecimal/math'

module Taxable
  # Requires price and exempt_from methods

  def total_tax
    sales_tax + import_duty
  end

  def shelf_price
    BigDecimal.new(price)
  end

  def sales_tax
    return BigDecimal('0.0') if exempt_from(:sales_tax)
    Taxable.round_up_to_nearest_five_cents(tax_value(shelf_price, 10))
  end

  def import_duty
    return BigDecimal('0.0') if exempt_from(:import_duty)
    Taxable.round_up_to_nearest_five_cents(tax_value(shelf_price, 5))
  end

  def tax_value(price, tax)
    price * tax * 0.01
  end

  def self.round_up_to_nearest_five_cents(value)
    BigDecimal.new((value*20).ceil) / 20.0
  end
end
