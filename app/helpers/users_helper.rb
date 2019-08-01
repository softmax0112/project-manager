# frozen_string_literal: true

module UsersHelper
  def enable_or_disable(user)
    user.enabled? ? 'Disable' : 'Enable'
  end

  def image_url_validate(url)
    url.blank? ? 'silhouette.png' : url
  end
end
