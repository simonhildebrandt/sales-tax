require 'spec_helper'
require_relative '../basket'

describe Basket do
  it "can collect items from data" do
    subject.parse_data(basket_data('input1.csv'))
    expect(subject.items[0]).to have_attributes(quantity: 1, product: 'book', price: '12.49')
    expect(subject.items[1]).to have_attributes(quantity: 1, product: 'music cd', price: '14.99')
    expect(subject.items[2]).to have_attributes(quantity: 1, product: 'chocolate bar', price: '0.85')
  end

  it "calculates the correct totals for the first example basket" do
    subject.parse_data(basket_data('input1.csv'))
    expect(subject.total_tax).to eq bd('1.50')
    expect(subject.total_price).to eq bd('29.83')
  end

  it "calculates the correct totals for the second example basket" do
    subject.parse_data(basket_data('input2.csv'))
    expect(subject.total_tax).to eq bd('7.65')
    expect(subject.total_price).to eq bd('65.15')
  end

  it "calculates the correct totals for the third example basket" do
    subject.parse_data(basket_data('input3.csv'))
    expect(subject.total_tax).to eq bd('6.70')
    expect(subject.total_price).to eq bd('74.68')
  end
end
