# frozen_string_literal: true

module UsersHelper
  def enable_or_disable(user)
    if user.enabled
      'Disable'
    else
      'Enable'
    end
  end
end
