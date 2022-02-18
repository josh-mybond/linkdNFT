json.extract! nft, :id, :token_link, :owner_name, :wallet_address, :nft_id, :created_at, :updated_at
json.url nft_url(nft, format: :json)
