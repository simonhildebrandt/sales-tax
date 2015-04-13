module Taxable
  def sales_tax
    Taxable.round_up_to_nearest_five_cents(tax_value(shelf_price, 10))
  end

  def import_duty
    Taxable.round_up_to_nearest_five_cents(tax_value(shelf_price, 5))
  end

  def tax_value(price, tax)
    price * tax * 0.01
  end

  def self.round_up_to_nearest_five_cents(value)
    (value*20).ceil / 20.0
  end
end
