class Order < ApplicationRecord
  enum pay_method: { credit_card: 0, transfer: 1 }
  enum status: { status0: 0, status1: 1, status2: 2, status3: 3, status4: 4 }
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  
  def address_display
    '〒' + invoice_postalcode + ' ' + invoice_address + ' ' + invoice_name 
  end
end
