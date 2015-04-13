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

  def shelf_price
    @price
  end

  def exempt_from(tax)
    !@tax_categories.fetch(tax, false)
  end
end

describe Taxable do

  context "applies taxes selectively" do
    let(:book) { TaxableClass.new(12.49, false, false) }
    let(:imported_book) { TaxableClass.new(12.49, false, true) }
    let(:compact_disc) { TaxableClass.new(14.99, true, false) }
    let(:imported_compact_disc) { TaxableClass.new(14.99, true, true) }

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
    let(:compact_disc) { TaxableClass.new(14.99) }

    context "of 10% for sales tax" do
      it { expect(compact_disc.sales_tax).to eq 1.50 }
    end

    context "of 5% for import duty" do
      it { expect(compact_disc.import_duty).to eq 0.75 }
    end

    context "and total tax" do
      it { expect(compact_disc.total_tax).to eq 2.25 }
    end
  end


  context "rounds up to nearest five cents" do
    # TODO: Consider cooking the values out and creating a loop
    it { expect(Taxable.round_up_to_nearest_five_cents(0.01)).to eq 0.05 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.04)).to eq 0.05 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.05)).to eq 0.05 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.06)).to eq 0.10 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.09)).to eq 0.10 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.10)).to eq 0.10 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.11)).to eq 0.15 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.15)).to eq 0.15 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.16)).to eq 0.20 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.19)).to eq 0.20 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.40)).to eq 0.40 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.41)).to eq 0.45 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.45)).to eq 0.45 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.46)).to eq 0.50 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.50)).to eq 0.50 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.50)).to eq 0.50 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.60)).to eq 0.60 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.95)).to eq 0.95 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.96)).to eq 1.00 }
    it { expect(Taxable.round_up_to_nearest_five_cents(0.99)).to eq 1.00 }
    it { expect(Taxable.round_up_to_nearest_five_cents(1.00)).to eq 1.00 }
    it { expect(Taxable.round_up_to_nearest_five_cents(1.01)).to eq 1.05 }
  end
end
