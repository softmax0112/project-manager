# frozen_string_literal: true

module PaymentsHelper
  def decide_payments_controller_action
    if current_user.admin?
      decide_admin_payments_controller_action
    else
      decide_manager_payments_controller_action
    end
  end

  def decide_admin_payments_controller_action
    if params[:id].nil?
      url_for(controller: 'admin/payments', action: 'create')
    else
      url_for(controller: 'admin/payments', action: 'update')
    end
  end

  def decide_manager_payments_controller_action
    if params[:id].nil?
      url_for(controller: 'manager/payments', action: 'create')
    else
      url_for(controller: 'manager/payments', action: 'update')
    end
  end

  def decide_payment_path(payment)
    current_user.admin? ? admin_payment_path(payment) : manager_payment_path(payment)
  end

  def decide_payments_path
    current_user.admin? ? admin_payments_path : manager_payments_path
  end

  def new_decide_payment_path
    current_user.admin? ? new_admin_payment_path : new_manager_payment_path
  end

  def edit_decide_payment_path(payment)
    current_user.admin? ? edit_admin_payment_path(payment) : edit_manager_payment_path(payment)
  end
end
