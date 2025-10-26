# app/controllers/lista_controller.rb
class ListaController < ApplicationController
  before_action :set_tags, only: [:index, :create, :ordenar]

  def index
    @itens = Item.includes(:tags)
  end

  def show
    @lista = Lista.find(params[:id])
    @itens = @lista.items
  end

  def create
    @item = Item.new(item_params)
    @item.list = current_list   # supondo que a lista vem do contexto do usuário
    @item.added_by = current_user

    if @item.save
      if params[:tag_ids].present?
        @item.tags << Tag.where(id: params[:tag_ids])
      end
      redirect_to lista_path, notice: 'Item adicionado com sucesso.'
    else
      @itens = Item.includes(:tags)
      render :index
    end
  end

  def ordenar
    if params[:tag_id].present?
      @itens = Item.filter_by_tag(params[:tag_id])
    elsif params[:ordem] == 'agrupar'
      @itens = Item.sorted_by_tag
    else
      @itens = Item.includes(:tags).order(:created_at)
    end
    render :index
  end

  private

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
