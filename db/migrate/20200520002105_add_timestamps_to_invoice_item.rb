class AddTimestampsToInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :created_at, :datetime, null: false
    add_column :invoice_items, :updated_at, :datetime, null: false
  end
end
