module ApplicationHelper
  def auth_token_view token
    token ? "Token: #{token}" : "no token"
  end
end
