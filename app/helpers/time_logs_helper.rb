# frozen_string_literal: true

module TimeLogsHelper
  def decide_time_logs_controller_action
    if current_user.admin?
      decide_admin_time_logs_controller_action
    else
      decide_manager_time_logs_controller_action
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

  def decide_time_log_path(time_log)
    current_user.admin? ? admin_time_log_path(time_log) : manager_time_log_path(time_log)
  end

  def decide_time_logs_path
    current_user.admin? ? admin_time_logs_path : manager_time_logs_path
  end

  def new_decide_time_log_path
    current_user.admin? ? new_admin_time_log_path : new_manager_time_log_path
  end

  def edit_decide_time_log_path(time_log)
    current_user.admin? ? edit_admin_admin_time_log_path(time_log) : edit_manager_manager_time_log_path(time_log)
  end
end
