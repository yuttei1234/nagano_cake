class Address < ApplicationRecord

 belongs_to :customer

 def full_address
  '〒' + postal_code + ' ' + addresses + ' ' + name
 end

end