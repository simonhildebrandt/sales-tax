module Helpers
  def basket_data(filename)
    open(File.expand_path(File.join('..', 'baskets', filename + '.txt'), __FILE__))
  end

  def basket_text(filename)
    basket_data(filename).readlines[1..-1].join
  end

  def bd(f)
    BigDecimal.new(f)
  end
end
