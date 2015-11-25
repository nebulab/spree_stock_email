Spree::Variant.class_eval do

  has_many :stock_emails, dependent: :destroy
  
end
