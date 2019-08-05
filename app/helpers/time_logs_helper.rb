# frozen_string_literal: true

module TimeLogsHelper
  def decide_time_logs_controller_action
    if current_user.admin?
      decide_admin_time_logs_controller_action
    elsif current_user.manager?
      decide_manager_time_logs_controller_action
    else
      decide_user_time_logs_controller_action
    end
  end

  def decide_admin_time_logs_controller_action
    if params[:id].nil?
      url_for(controller: 'admin/time_logs', action: 'create')
    else
      url_for(controller: 'admin/time_logs', action: 'update')
    end
  end

  def decide_manager_time_logs_controller_action
    if params[:id].nil?
      url_for(controller: 'manager/time_logs', action: 'create')
    else
      url_for(controller: 'manager/time_logs', action: 'update')
    end
  end

  def decide_user_time_logs_controller_action
    if params[:id].nil?
      url_for(controller: 'time_logs', action: 'create')
    else
      url_for(controller: 'time_logs', action: 'update')
    end
  end

  def decide_time_log_path(time_log)
    if current_user.admin?
      admin_time_log_path(time_log)
    elsif current_user.manager?
      manager_time_log_path(time_log)
    else
      time_log_path(time_log)
    end
  end

  def decide_time_logs_path
    if current_user.admin?
      admin_time_logs_path
    elsif current_user.manager?
      manager_time_logs_path
    else
      time_logs_path
    end
  end

  def new_decide_time_log_path_project(project)
    if current_user.admin?
      new_admin_time_log_path(project)
    elsif current_user.manager?
      new_manager_time_log_path(project)
    else
      new_time_log_path(project)
    end
  end

  def new_decide_time_log_path
    if current_user.admin?
      new_admin_time_log_path
    elsif current_user.manager?
      new_manager_time_log_path
    else
      new_time_log_path
    end
  end

  def edit_decide_time_log_path(time_log)
    if current_user.admin?
      edit_admin_time_log_path(time_log)
    elsif current_user.manager?
      edit_manager_time_log_path(time_log)
    else
      edit_time_log_path(time_log)
    end
  end
end
