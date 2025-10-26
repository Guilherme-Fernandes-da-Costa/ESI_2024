class ItemsController < ApplicationController
  # Associações de callback
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  # Ação que carrega o set padrão de itens. Agora é chamado por :index e :sort.
  before_action :load_items, only: [:index, :sort] 

  # GET /items
  def index
    # Lógica de exibição inicial
    @item = Item.new # Para o formulário de adição rápida
    @tags = Tag.all # Assumindo Tag.all ou Tag.pre_registered existe
    
    # @items já está carregado por load_items (ordenado por created_at: :desc)
    # A lógica complexa de filtro/agrupamento foi movida para a action #sort
  end

  # GET /items/new - Necessário para new_item_path
  def new
    @item = Item.new
    @tags = Tag.all
  end

  # GET /items/:id - Ação show (requer set_item)
  def show
    # @item é definido por set_item
  end

  # GET /items/:id/edit - Ação edit (requer set_item)
  def edit
    # @item é definido por set_item
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    
    # Se você está usando has_many :tags, through: :item_tags, certifique-se
    # que o método 'tag_ids' no item_params irá associar as tags.
    if @item.save
      redirect_to items_path, notice: "Item '#{@item.name}' adicionado com sucesso."
    else
      # Recarrega dados para re-renderização
      @items = Item.all.order(created_at: :desc)
      @tags = Tag.all # Assumindo Tag.all ou Tag.pre_registered existe
      render :index, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/:id - Ação update (requer set_item)
  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item foi atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /items/:id - Ação destroy (requer set_item)
  def destroy
    @item.destroy
    redirect_to items_url, notice: "Item foi excluído com sucesso."
  end

  # GET /items/sort
  # Esta action lida com a lógica de ordenação/filtro (Agrupar/Filtrar/Desagrupar)
  def sort
    @tags = Tag.all

    case params[:sort_option]
    when 'group'
      # Ordena por tag (necessita de Item.sorted_by_tag ou similar)
      # Assumindo que o Item model tem o scope Item.sorted_by_tag
      @items = Item.sorted_by_tag
      flash.now[:notice] = "Itens agrupados por categoria (tag)."
    when 'ungroup'
      # Restaura a ordenação padrão, que é a mesma de load_items
      @items = Item.order(created_at: :desc)
      flash.now[:notice] = "Ordenação restaurada."
    when 'filter_by_tag'
      # Filtra por ID de tag (necessita de Item.filter_by_tag ou similar)
      tag_id = params[:tag_id]
      @items = Item.filter_by_tag(tag_id)
      flash.now[:notice] = "Itens filtrados pela tag: #{Tag.find(tag_id).name}" if tag_id.present?
    end

    # Reutiliza a view index para exibir os resultados ordenados/filtrados
    render :index
  end
  

  private

  def set_item
    @item = Item.find(params[:id])
  end

  # Carrega o set padrão de itens (ordenado por created_at desc)
  def load_items
    @items = Item.order(created_at: :desc)
  end

  def item_params
    # Mantendo o formato para aceitar múltiplas tags (tag_ids: [])
    params.require(:item).permit(:name, :quantity, tag_ids: []) 
  end
end
