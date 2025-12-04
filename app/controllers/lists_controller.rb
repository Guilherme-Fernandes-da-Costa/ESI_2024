# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_list, only: %i[show reset]
  before_action :set_tags, only: %i[index create]

  def index
    @lista = current_list
    if @lista.present?
      @itens = @lista.items.includes(:tags)
    else
      @itens = Item.none
    end
  end

  def create
    name = params.dig(:list, :nome).presence || 'Sem nome'
    @lista = List.create(name: name)
    redirect_to lista_path
  end

  def update
    @lista = List.find(params[:id])
    if @lista.update(list_params)
      redirect_to lista_path, notice: 'Lista atualizada com sucesso.'
    else
      @lista = current_list
      @itens = @lista.present? ? @lista.items.includes(:tags) : Item.none
      render :index
    end
  end

  def show
    @total_estimado = @lista.items.sum(:preco)
    
    # Lógica de ordenação (Cenário 2)
    @items = @lista.items
    
    case params[:order]
    when 'agrupar'
      @items = @items.grouped_by_tag # Usa o scope definido no Model
    when 'desagrupar'
      @items = @items.order(created_at: :asc)
    when *@items.pluck(:tag).compact.uniq
      @items = @items.where(tag: params[:order])
    else
      @items = @items.order(created_at: :asc)
    end

    @available_tags = @lista.items.pluck(:tag).compact.uniq
  end


  def reset
    begin
      @lista.reset!(by: current_user)
      respond_to do |format|
        format.html { redirect_to @lista, notice: 'Lista reiniciada com sucesso.' }
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
    if params[:id].present?
      @lista = List.find(params[:id])
    else
      @lista = current_list
    end
    @list = @lista
  end

  def item_params
    params.require(:item).permit(:name)
  end

  def list_params
    params.require(:list).permit(:nome)
  end

  def set_tags
    @tags = Tag.pre_registered
  end

  def current_list
    # Substituir com sua lógica real
    List.first
  end
end
