class ListsController < ApplicationController
  before_action :set_list, only: %i[show reset]


# POST /lists/:id/reset
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
end