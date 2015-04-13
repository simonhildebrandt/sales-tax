require 'spec_helper'
require_relative '../taxable'

class TaxableClass
  include Taxable

  def initialize(price, sales_tax=true, import_duty=true)
    @price = price
    @tax_categories = {
      sales_tax: sales_tax,
      import_duty: import_duty
    }
  end

  def price
    @price
  end

  def exempt_from(tax)
    !@tax_categories.fetch(tax, false)
  end
end

describe Taxable do

  context "applies taxes selectively" do
    let(:book) { TaxableClass.new('12.49', false, false) }
    let(:imported_book) { TaxableClass.new('12.49', false, true) }
    let(:compact_disc) { TaxableClass.new('14.99', true, false) }
    let(:imported_compact_disc) { TaxableClass.new('14.99', true, true) }

    it { expect(book.sales_tax).to eq 0.0 }
    it { expect(book.import_duty).to eq 0.0 }

    it { expect(compact_disc.sales_tax).to eq 1.50 }
    it { expect(compact_disc.import_duty).to eq 0.0 }

    it { expect(imported_book.sales_tax).to eq 0.0 }
    it { expect(imported_book.import_duty).to eq 0.65 }

    it { expect(imported_compact_disc.sales_tax).to eq 1.50 }
    it { expect(imported_compact_disc.import_duty).to eq 0.75 }
  end

  context "calculates taxes" do
    let(:compact_disc) { TaxableClass.new('14.99') }

    context "of 10% for sales tax" do
      it { expect(compact_disc.sales_tax).to eq bd('1.50') }
    end

    context "of 5% for import duty" do
      it { expect(compact_disc.import_duty).to eq bd('0.75') }
    end

    context "and total tax" do
      it { expect(compact_disc.total_tax).to eq bd('2.25') }
    end
  end


  it "rounds up to nearest five cents" do
    values = [
      ['0.01', '0.05'],
      ['0.04', '0.05'],
      ['0.05', '0.05'],
      ['0.06', '0.10'],
      ['0.09', '0.10'],
      ['0.10', '0.10'],
      ['0.11', '0.15'],
      ['0.15', '0.15'],
      ['0.16', '0.20'],
      ['0.19', '0.20'],
      ['0.40', '0.40'],
      ['0.41', '0.45'],
      ['0.45', '0.45'],
      ['0.46', '0.50'],
      ['0.50', '0.50'],
      ['0.50', '0.50'],
      ['0.60', '0.60'],
      ['0.95', '0.95'],
      ['0.96', '1.00'],
      ['0.99', '1.00'],
      ['1.00', '1.00'],
      ['1.01', '1.05']
    ]

    values.each do |unrounded, rounded|
      expect(Taxable.round_up_to_nearest_five_cents(bd(unrounded))).to eq bd(rounded)
    end
  end
end
