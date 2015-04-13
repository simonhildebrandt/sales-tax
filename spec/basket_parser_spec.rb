require 'spec_helper'
require_relative '../basket_parser'

describe BasketParser do
  def basket_path(filename)
    File.expand_path(File.join('..', 'baskets', filename), __FILE__)
  end

  it "can parse the first example basket" do
    items = described_class.parse_file(basket_path('input1.csv'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'book', price: 12.49)
    expect(items[1]).to have_attributes(quantity: 1, product: 'music cd', price: 14.99)
    expect(items[2]).to have_attributes(quantity: 1, product: 'chocolate bar', price: 0.85)
  end

  it "can parse the second example basket" do
    items = described_class.parse_file(basket_path('input2.csv'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'imported box of chocolates', price: 10.00)
    expect(items[1]).to have_attributes(quantity: 1, product: 'imported bottle of perfume', price: 47.50)
  end

  it "can parse the third example basket" do
    items = described_class.parse_file(basket_path('input3.csv'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'imported bottle of perfume', price: 27.99)
    expect(items[1]).to have_attributes(quantity: 1, product: 'bottle of perfume', price: 18.99)
    expect(items[2]).to have_attributes(quantity: 1, product: 'packet of headache pills', price: 9.75)
    expect(items[3]).to have_attributes(quantity: 1, product: 'box of imported chocolates', price: 11.25)
  end
end
