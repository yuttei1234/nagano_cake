class OrderDetail < ApplicationRecord
  
  belongs_to :orders
  belongs_to :items
  
  enum making_status: { impossible: 0, waiting: 1, making: 2, finish: 3 }
  
end