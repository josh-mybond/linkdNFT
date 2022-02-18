class CreateNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :nfts do |t|
      t.string :token_link
      t.string :owner_name
      t.string :wallet_address
      t.string :nft_id

      t.timestamps
    end
  end
end
