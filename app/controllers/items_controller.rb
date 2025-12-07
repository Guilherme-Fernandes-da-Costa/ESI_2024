class ItemsController < ApplicationController
  before_action :require_login
  before_action :set_list
  before_action :set_item, only: [:toggle_comprado, :update]

  # GET /lists/:list_id/items
  # Como a rota :index existe, você pode querer implementar esta action
  def index
    @items = @list.items.all
    # O cálculo do total deve somar o preço de todos os itens
    @total_estimado = @itens.sum(:preco)
  end

  # GET /lists/:list_id/items/new
  def new
    @item = @list.items.new
    # Tags pré-cadastradas:
    @available_tags = ["frios", "horti-fruit", "carne", "padaria", "limpeza"] 
  end

  # POST /lists/:list_id/items
  def create
    @item = @list.items.new(item_params)
    @item.added_by = current_user
    if @item.save
      # Redireciona para a página de visualização da lista para ver o item recém-adicionado
      redirect_to list_path(@list), notice: 'Item adicionado com sucesso.'
    else
      # Re-renderiza o formulário em caso de erro
      @available_tags = ["frios", "horti-fruit", "carne", "padaria", "limpeza"]
      render :new, status: :unprocessable_entity
    end
  end

  def update
      if @item.update(item_params)
        respond_to do |format|
          format.html { redirect_to list_path(@list), notice: 'Item atualizado com sucesso.' }
          format.js   # Isso renderizará update.js.erb para atualização AJAX
        end
      else
        respond_to do |format|
          format.html { redirect_to list_path(@list), alert: 'Não foi possível atualizar o item.' }
          format.js { render json: { error: @item.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

  # PATCH /lists/:list_id/items/:id/toggle_comprado
  def toggle_comprado
      # Alterna entre marcado/desmarcado
      novo_valor = !@item.comprado
      quantidade_a_comprar = novo_valor ? @item.quantity : 0

      if @item.update(comprado: novo_valor, quantidade_comprada: quantidade_a_comprar)
        respond_to do |format|
          format.html { redirect_to list_path(@list), notice: "Status do item '#{@item.name}' atualizado." }
          format.js   # Isso renderizará toggle_comprado.js.erb
        end
      else
        respond_to do |format|
          format.html { redirect_to list_path(@list), alert: "Não foi possível atualizar o item." }
          format.js { render json: { error: @item.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

  private

  # Encontra o item com base no :id da rota (que é :item_id na rota aninhada)
  def set_item
    # Busca o item DENTRO da lista correta
    @item = @list.items.find(params[:id]) 
  end

  def set_list
    # Note: O find_by_id pode ser mais seguro se a lista puder ser nula, mas find é padrão.
    @list = List.find(params[:list_id])
  end

   def item_params
      params.require(:item).permit(:name, :quantity, :preco, :tag, :quantidade_comprada, :comprado)
    end
end
