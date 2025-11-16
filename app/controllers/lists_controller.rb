# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_list, only: %i[show reset]

  def show
    # implementado se necessário — placeholder simples
    render :show
  end

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
    # Não filtrar por current_user aqui: queremos que a ação sempre encontre a lista
    # e deixe a checagem de permissão para List#reset!, que é o que os testes esperam.
    @list = List.find(params[:id])
  end
end

