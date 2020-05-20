class CreateInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true
      t.string :quantity
      t.integer :unit_price
    end
  end
end
