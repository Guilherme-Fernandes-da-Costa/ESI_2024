class ItemsController < ApplicationController
  before_action :set_lista
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = @lista.items.includes(:tags)
  end

  def new
    @item = @lista.items.build
  end

  def create
    @item = @lista.items.build(item_params)
    @item.added_by = current_user
    if @item.save
      redirect_to lista_items_path(@lista), notice: 'Item criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to lista_items_path(@lista), notice: 'Item atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to lista_items_path(@lista), notice: 'Item removido.'
  end

  # Filtrar por tag
  def filter
    tag_name = params[:tag_name]
    @items = @lista.items.with_tag(tag_name)
    render :index
  end

  # Agrupar por tag
  def group
    @items = @lista.items.includes(:tags).order('tags.name ASC')
    render :index
  end

  private

  def set_lista
    @lista = Lista.find(params[:lista_id])
  end

  def set_item
    @item = @lista.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, tag_ids: [])
  end
end
