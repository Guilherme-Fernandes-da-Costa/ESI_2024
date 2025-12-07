# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
<<<<<<< HEAD
      redirect_to lists_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "Email ou senha inválidos"
=======
      redirect_to lists_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = 'Email ou senha inválidos'
>>>>>>> 0d98f6d (Implementa sistema de autenticação)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
<<<<<<< HEAD
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end
=======
    redirect_to root_path, notice: 'Logout realizado com sucesso!'
  end
end
>>>>>>> 0d98f6d (Implementa sistema de autenticação)
