module ApplicationHelper

  def auth_token_view token
    token ? "Token: #{token}" : ""

  end
end
