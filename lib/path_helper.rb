def base_url
  'https://instagram.com'
end

def login_path
  '/api/v1/accounts/login/'
end

def popular_path
  '/api/v1/feed/popular/'
end

def like_path(image_id)
  "/api/v1/media/#{image_id}/like/"
end

def comment_path(image_id)
  "/api/v1/media/#{image_id}/comment/"
end

def follow_user_path(user_id)
  "/api/v1/friendships/create/#{user_id}/"
end