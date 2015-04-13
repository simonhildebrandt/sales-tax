require 'spec_helper'
require_relative '../taxable'

describe Taxable do
  let(:taxable_class) { Class.new { include Taxable } }

  context "calculates a 10% sales tax" do
    let(:compact_disc) { taxable_class.new }
    it { expect(compact_disc.sales_tax).to eq 1.50 }
  end
end
