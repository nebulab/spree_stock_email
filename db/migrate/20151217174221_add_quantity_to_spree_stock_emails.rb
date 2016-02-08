class AddQuantityToSpreeStockEmails < ActiveRecord::Migration
  def change
    add_column :spree_stock_emails, :quantity, :integer, default: 1
  end
end
