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

  def decide_controller_action
    self.class.parent == Manager ? decide_manager_controller_action : decide_admin_controller_action
  end

  def decide_manager_controller_action
    if params[:id].nil?
      url_for(controller: 'manager/clients', action: 'create')
    else
      url_for(controller: 'manager/clients', action: 'update')
    end
  end

  def decide_admin_controller_action
    if params[:id].nil?
      url_for(controller: 'admin/clients', action: 'create')
    else
      url_for(controller: 'admin/clients', action: 'update')
    end
  end

  def decide_projects_controller_action
    if current_user.admin?
      decide_admin_projects_controller_action
    else
      decide_manager_projects_controller_action
    end
  end

  def decide_admin_projects_controller_action
    if params[:id].nil?
      url_for(controller: 'admin/admin_projects', action: 'create')
    else
      url_for(controller: 'admin/admin_projects', action: 'update')
    end
  end

  def decide_manager_projects_controller_action
    if params[:id].nil?
      url_for(controller: 'manager/manager_projects', action: 'create')
    else
      url_for(controller: 'manager/manger_projects', action: 'update')
    end
  end

  def decide_client_path
    current_user.admin? ? admin_clients_path : manager_clients_path
  end

  def decide_project_path(project)
    current_user.admin? ? admin_admin_project_path(project) : manager_manager_project_path(project)
  end

  def decide_projects_path
    current_user.admin? ? admin_admin_projects_path : manager_manager_projects_path
  end

  def new_decide_project_path
    current_user.admin? ? new_admin_admin_project_path : new_manager_manager_project_path
  end

  def edit_decide_project_path(project)
    current_user.admin? ? edit_admin_admin_project_path(project) : edit_manager_manager_project_path(project)
  end
end
