json.extract! admin, :id, :name, :email, :password, :auth_token, :created_at, :updated_at
json.url admin_url(admin, format: :json)
