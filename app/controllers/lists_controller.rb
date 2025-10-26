# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_tags, only: [:index, :create, :ordenar]

  def index
    @itens = Item.includes(:tags)
  end
  
  def create
    @item = Item.new(item_params)
    @item.list = current_list   # supondo que a lista vem do contexto do usuário
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

  # GET /lists/:id
  def show
    @list = List.find(params[:id])
    
    # Lógica de ordenação (Cenário 2)
    @items = @list.items
    
    case params[:order]
    when 'agrupar'
      @items = @items.grouped_by_tag # Usa o scope definido no Model
    when 'desagrupar'
      # Implementação "Desagrupar": Reverte para a ordem original (padrão)
      # Se você usou `default_scope { order(created_at: :asc) }` no model, 
      # essa seria a ordem, caso contrário, será a ordem padrão do DB (ID).
      @items = @items.order(created_at: :asc) # Assumindo que a ordem original é a de criação
    when *@items.pluck(:tag).compact.uniq
      # Filtra por uma tag específica
      @items = @items.where(tag: params[:order])
    else
      @items = @items.order(created_at: :asc) # Ordem padrão, se não houver parâmetro
    end

    # Coleta tags únicas para o botão "Ordenar Lista"
    @available_tags = @list.items.pluck(:tag).compact.uniq
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
