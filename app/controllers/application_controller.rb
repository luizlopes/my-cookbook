class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate_admin!
    redirect_to(root_path, alert: 'Usuário sem permissão') unless admin_user?
  end

  def admin_user?
    current_user&.admin?
  end
end
