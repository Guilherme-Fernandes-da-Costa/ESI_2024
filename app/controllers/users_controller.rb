# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
<<<<<<< HEAD
      redirect_to lists_path, notice: "Conta criada com sucesso!"
=======
      redirect_to lists_path, notice: 'Conta criada com sucesso!'
>>>>>>> 0d98f6d (Implementa sistema de autenticação)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> 0d98f6d (Implementa sistema de autenticação)
