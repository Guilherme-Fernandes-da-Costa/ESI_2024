# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_list, only: %i[show reset]
  before_action :set_tags, only: %i[index create]

  def index
    @itens = Item.includes(:tags)
  end

  def show
    @total_estimado = @list.items.sum(:preco)
    
    # Lógica de ordenação (Cenário 2)
    @items = @list.items
    
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

    @available_tags = @list.items.pluck(:tag).compact.uniq
  end

  def create
    @item = Item.new(item_params)
    @item.list = current_list
    @item.added_by = current_user

    if @item.save
      if params[:tag_ids].present?
        @item.tags << Tag.where(id: params[:tag_ids])
      end
      redirect_to list_path, notice: 'Item adicionado com sucesso.'
    else
      @itens = Item.includes(:tags)
      render :index
    end
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
    @list = List.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name)
  end

  def set_tags
    @tags = Tag.pre_registered
  end

  def current_list
    # Substituir com sua lógica real
    List.first
  end
end
