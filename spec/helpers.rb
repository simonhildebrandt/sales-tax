module Helpers
  def basket_data(filename)
    open(File.expand_path(File.join('..', 'baskets', filename), __FILE__))
  end

  def bd(f)
    BigDecimal.new(f)
  end
end
