class AddQuantityToSpreeStockEmails < ActiveRecord::Migration
  def change
    add_column :spree_stock_emails, :quantity, :integer
  end
end
