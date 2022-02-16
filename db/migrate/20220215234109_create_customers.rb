class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :email
      t.string :linked_in_profile

      t.timestamps
    end
  end
end
