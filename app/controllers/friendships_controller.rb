class FriendshipsController < ApplicationController
    before_action :authenticate_user! 

    def index
        @friends = current_user.friendships.includes(:friend)
    end

    def create
        friend = User.find_by(email: params[:email])

        if friend.nil?
            redirect_back fallback_location: root_path, alert: "Usuário não encontrado."
            return
        end

        friendship = Friendship.new(user: current_user, friend: friend)

        if friendship.save
            redirect_back fallback_location: root_path, notice: "Amigo adicionado com sucesso!"
        else
            redirect_back fallback_location: root_path, alert: friendship.errors.full_messages.join(", ")
        end
    end

    def destroy
        friendship = Friendship.find(params[:id])  # ← CORRIGIDO
        friendship.destroy
        redirect_back fallback_location: root_path, notice: "Amigo removido."
    end
end