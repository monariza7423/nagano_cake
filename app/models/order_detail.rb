class OrderDetail < ApplicationRecord
  enum product_status: { status0: 0, status1: 1, status2: 2, status3: 3}
  belongs_to :order
end
