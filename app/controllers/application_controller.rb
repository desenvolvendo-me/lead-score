class ApplicationController < ActionController::Base
  helper Railsui::ThemeHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  set_current_tenant_through_filter
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?
  before_action :set_tenant

  private

  def set_tenant
    set_current_tenant(current_user.client) if current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name, :avatar, { client_attributes: [:document] }]
    )
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(
      :account_update, keys: [
        :name, :avatar, { client_attributes: [:document] }
      ]
    )
  end
end
