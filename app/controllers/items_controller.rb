class ItemsController < ApplicationController
  before_action :set_items, only: [:index, :sort]

  def index
    # Lógica de exibição inicial (ou após desagrupar/sem filtro)
    @item = Item.new
    @tags = Tag.pre_registered
    # Verifica se há parâmetros de filtro ou ordenação, senão exibe tudo
    if params[:tag].present?
      @items = Item.with_tag(params[:tag]).order(created_at: :desc)
    elsif params[:group_by_tag] == 'true'
      # Ordena alfabeticamente pela tag principal ou por nome
      @items = @items.joins(:tags).order('tags.name ASC, items.created_at DESC').uniq
    else
      @items = @items.order(created_at: :desc)
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to lista_path, notice: "Item '#{@item.name}' adicionado com sucesso."
    else
      @items = Item.all.order(created_at: :desc)
      @tags = Tag.pre_registered
      render :index, status: :unprocessable_entity
    end
  end

  private

  def item_params
    # Permite 'name' (do 'novo item') e 'tag_names' (do campo opcional)
    params.require(:item).permit(:name, tag_ids: [])
  end

  def set_items
    @items = Item.all
  end
end
