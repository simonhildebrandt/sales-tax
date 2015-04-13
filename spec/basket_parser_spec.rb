require 'spec_helper'
require_relative '../basket_parser'

describe BasketParser do

  it "can parse the first example basket" do
    items = described_class.parse_data(basket_data('input1'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'book', price: '12.49')
    expect(items[1]).to have_attributes(quantity: 1, product: 'music cd', price: '14.99')
    expect(items[2]).to have_attributes(quantity: 1, product: 'chocolate bar', price: '0.85')
  end

  it "can parse the second example basket" do
    items = described_class.parse_data(basket_data('input2'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'imported box of chocolates', price: '10.00')
    expect(items[1]).to have_attributes(quantity: 1, product: 'imported bottle of perfume', price: '47.50')
  end

  it "can parse the third example basket" do
    items = described_class.parse_data(basket_data('input3'))
    expect(items[0]).to have_attributes(quantity: 1, product: 'imported bottle of perfume', price: '27.99')
    expect(items[1]).to have_attributes(quantity: 1, product: 'bottle of perfume', price: '18.99')
    expect(items[2]).to have_attributes(quantity: 1, product: 'packet of headache pills', price: '9.75')
    expect(items[3]).to have_attributes(quantity: 1, product: 'box of imported chocolates', price: '11.25')
  end
end
