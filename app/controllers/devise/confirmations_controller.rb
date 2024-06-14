module Devise
  class ConfirmationsController < DeviseController
    def show
      self.resource = resource_class
                      .confirm_by_token(params[:confirmation_token])

      if resource.errors.empty?
        redirect_to new_user_session_path,
                    notice: I18n.t('devise.confirmations.confirmed')
      else
        redirect_to new_user_session_path,
                    notice: I18n.t('devise.failure.unconfirmed')
      end
    end
  end
end
