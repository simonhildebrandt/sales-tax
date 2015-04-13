require 'spec_helper'
require_relative '../basket'

describe Basket do
  it "can collect items from data" do
    subject.parse_data(basket_data('input1'))
    expect(subject.items[0]).to have_attributes(quantity: 1, product: 'book', price: '12.49')
    expect(subject.items[1]).to have_attributes(quantity: 1, product: 'music cd', price: '14.99')
    expect(subject.items[2]).to have_attributes(quantity: 1, product: 'chocolate bar', price: '0.85')
  end

  it "calculates the correct totals for the first example basket" do
    subject.parse_data(basket_data('input1'))
    expect(subject.total_tax).to eq bd('1.50')
    expect(subject.total_price).to eq bd('29.83')
  end

  it "calculates the correct totals for the second example basket" do
    subject.parse_data(basket_data('input2'))
    expect(subject.total_tax).to eq bd('7.65')
    expect(subject.total_price).to eq bd('65.15')
  end

  it "calculates the correct totals for the third example basket" do
    subject.parse_data(basket_data('input3'))
    expect(subject.total_tax).to eq bd('6.70')
    expect(subject.total_price).to eq bd('74.68')
  end

  it "generates the expected output for the first example basket" do
    out = basket_text('input1') + "Sales Taxes: 1.50\nTotal: 29.83"

    subject.parse_data(basket_data('input1'))
    expect(subject.print_receipt).to eq(out)
  end

  it "generates the expected output for the second example basket" do
    out = basket_text('input2') + "Sales Taxes: 7.65\nTotal: 65.15"

    subject.parse_data(basket_data('input2'))
    expect(subject.print_receipt).to eq(out)
  end

  it "generates the expected output for the third example basket" do
    out = basket_text('input3') + "Sales Taxes: 6.70\nTotal: 74.68"

    subject.parse_data(basket_data('input3'))
    expect(subject.print_receipt).to eq(out)
  end
end
