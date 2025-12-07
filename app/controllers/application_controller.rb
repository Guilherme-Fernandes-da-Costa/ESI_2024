# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  helper_method :can_edit_quantity?
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Você precisa estar logado para acessar esta página."
      redirect_to login_path
    end
  end
  private

    def can_edit_quantity?(item)
      # Permite edição se o usuário for o dono da lista ou um usuário compartilhado
      current_user == item.list.owner || item.list.shared_users.include?(current_user)
    end
end