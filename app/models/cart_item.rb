class Cart_item < ApplicationRecord

  belongs_to :customers
  belongs_to :items

  def subtotal
    item.with_tax_price * amount
  end

  def total_price
    items.to_a.sum { |item| item.total_price }
  end

end