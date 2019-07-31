# frozen_string_literal: true

module ApplicationHelper
  def home_path
    return admin_user_path(current_user) if current_user.admin?
    return user_path(current_user) if current_user.user?
    return manager_user_path(current_user) if current_user.manager?
  end

  def enable_or_disable(user)
    user.enabled? ? 'Disable' : 'Enable'
  end

  def image_url_validate(url)
    url.blank? ? 'silhouette.png' : url
  end

  def get_controller_action
    params[:id].nil? ? url_for(:controller => 'manager/clients', :action => 'create') : url_for(:controller => 'manager/clients', :action => 'update')
  end
end
