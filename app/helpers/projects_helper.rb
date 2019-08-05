# frozen_string_literal: true

module ProjectsHelper
  def decide_projects_controller_action
    if current_user.admin?
      decide_admin_projects_controller_action
    elsif current_user.manager?
      decide_manager_projects_controller_action
    else
      decide_user_projects_controller_action
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
      url_for(controller: 'manager/manager_projects', action: 'update')
    end
  end

  def decide_user_projects_controller_action
    if params[:id].nil?
      url_for(controller: 'projects', action: 'create')
    else
      url_for(controller: 'projects', action: 'update')
    end
  end

  def decide_project_path(project)
    if current_user.admin?
      admin_admin_project_path(project)
    elsif current_user.manager?
      manager_manager_project_path(project)
    else
      project_path(project)
    end
  end

  def decide_projects_path
    if current_user.admin?
      admin_admin_projects_path
    elsif current_user.manaher?
      manager_manager_projects_path
    else
      projects_path
    end
  end

  def new_decide_project_path
    current_user.admin? ? new_admin_admin_project_path : new_manager_manager_project_path
  end

  def edit_decide_project_path(project)
    current_user.admin? ? edit_admin_admin_project_path(project) : edit_manager_manager_project_path(project)
  end
end
