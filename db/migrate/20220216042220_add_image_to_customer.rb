class AddImageToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :image, :string
  end
end
