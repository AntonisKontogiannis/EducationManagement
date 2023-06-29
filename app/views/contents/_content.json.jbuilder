json.extract! content, :id, :title, :subject_id, :type, :url, :category, :created_at, :updated_at
json.url content_url(content, format: :json)
