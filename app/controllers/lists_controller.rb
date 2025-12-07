# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :require_login
    before_action :set_list, only: %i[show edit update destroy reset]

    # GET /lists
    def index
      # Mostra listas do usuário (como owner) + listas compartilhadas
      @owned_lists = current_user.owned_lists
      @shared_lists = current_user.shared_lists
    end

    # GET /lists/new
    def new
      @list = List.new
    end

    # POST /lists
    def create
      @list = List.new(list_params)
      @list.owner = current_user  # Agora temos current_user definido

      if @list.save
        redirect_to @list, notice: 'Lista criada com sucesso.'
      else
        render :new, status: :unprocessable_entity
      end
    end

  # GET /lists/1/edit
  def edit
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'Lista atualizada com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    redirect_to lists_url, notice: 'Lista excluída com sucesso.'
  end

  # POST /lists/1/reset
  def reset
    begin
      @list.reset!(by: current_user)
      respond_to do |format|
        format.html { redirect_to @list, notice: 'Lista reiniciada com sucesso.' }
        format.json { render json: { success: true }, status: :ok }
      end
    rescue List::PermissionDenied
      respond_to do |format|
        format.html { head :forbidden }
        format.json { render json: { error: 'Falta de permissão' }, status: :forbidden }
      end
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)  # Note: 'list' não 'item'
  end
end