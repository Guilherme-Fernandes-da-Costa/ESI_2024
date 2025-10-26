class ItemsController < ApplicationController
  before_action :set_list

  # GET /lists/:list_id/items/new
  def new
    @item = @list.items.new
    # Tags pré-cadastradas:
    @available_tags = ["frios", "horti-fruit", "carne", "padaria", "limpeza"] 
  end

  # POST /lists/:list_id/items
  def create
    @item = @list.items.new(item_params)
    
    if @item.save
      # Redireciona para a página de visualização da lista para ver o item recém-adicionado
      redirect_to list_path(@list), notice: 'Item adicionado com sucesso.'
    else
      # Re-renderiza o formulário em caso de erro
      @available_tags = ["frios", "horti-fruit", "carne", "padaria", "limpeza"]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_list
    # Note: O find_by_id pode ser mais seguro se a lista puder ser nula, mas find é padrão.
    @list = List.find(params[:list_id])
  end

  def item_params
    # Adicionamos :tag como parâmetro permitido
    params.require(:item).permit(:name, :tag)
  end
end
