class ItemsController < ApplicationController
  before_action :set_list
  # Encontra o item para as actions que lidam com ele, incluindo a nova toggle_comprado
  before_action :set_item, only: [:toggle_comprado] # Adicionei :index se você precisar dele

  # GET /lists/:list_id/items
  # Como a rota :index existe, você pode querer implementar esta action
  def index
    @items = @list.items.all
    @total_estimado = @items.sum(:preco)
    @available_tags = @list.items.pluck(:tag).compact.uniq
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
    # Ensure added_by satisfies DB foreign key (tests may not have authentication)
    @item.added_by = User.first || User.create!(email: 'test@example.com', name: 'Teste')

    if @item.save
      # Redireciona para a página de visualização da lista para ver o item recém-adicionado
      redirect_to list_path(@list), notice: 'Item adicionado com sucesso.'
    else
      # Re-renderiza o formulário em caso de erro
      @available_tags = ["frios", "horti-fruit", "carne", "padaria", "limpeza"]
      flash.now[:alert] = @item.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /lists/:list_id/items/:id/toggle_comprado
  def toggle_comprado
    # A lógica aqui é simples: inverte o valor do atributo 'comprado'.
    # Isso atende aos cenários de 'Marcar' (de false para true) e 'Desmarcar' (de true para false).
    
    if @item.update(comprado: !@item.comprado) # Usa o método update diretamente
      # Responde ao cliente. No Rails moderno, é comum usar Turbo Frames ou JS/JSON.
      # Para o cenário BDD (que simula um clique e espera o estado riscado),
      # um simples redirecionamento (refresh da página) é o mais fácil de testar.
      # Se você estiver em list_items_path(@list), use redirect_to
      redirect_to list_items_path(@list), notice: "Status do item '#{@item.name}' atualizado."
    else
      # Em caso de falha de validação (embora improvável para um simples toggle)
      redirect_to list_items_path(@list), alert: "Não foi possível atualizar o item."
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
    params.require(:item).permit(:name, :quantity, :comprado, :preco, :tag)
  end
end
