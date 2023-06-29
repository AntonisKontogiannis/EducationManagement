json.extract! user, :id, :avatar, :first_name, :last_name, :email, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
