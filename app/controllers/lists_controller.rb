# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :require_login
  before_action :set_list, only: %i[show edit update destroy reset]

    # GET /lists
    def index
      # Mostra listas do usuário (como owner) + listas compartilhadas
      @owned_lists = current_user.owned_lists
      @shared_lists = current_user.shared_lists
    end


    # GET /lists/new
    def new
      @list = List.new
      # Criar 3 itens em branco
      3.times { @list.items.build }
    end

    # POST /lists
    def create
      @list = List.new(list_params.except(:items_attributes))
      @list.owner = current_user

      # Construir os itens MANUALMENTE para poder atribuir added_by
      if params[:list][:items_attributes]
        params[:list][:items_attributes].each do |index, item_attrs|
          item = @list.items.build(item_attrs.permit(:name, :quantity, :preco, :tag))
          item.added_by = current_user  # Atribui o usuário atual
        end
      end

      if @list.save
        redirect_to lists_path, notice: 'Lista criada com sucesso.'
      else
        # Reconstruir 3 itens vazios para o formulário se falhar
        3.times { @list.items.build } if @list.items.empty?
        render :new, status: :unprocessable_entity
      end
    end

  # GET /lists/1/edit
  def edit
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'Lista atualizada com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    redirect_to lists_url, notice: 'Lista excluída com sucesso.'
  end

  # POST /lists/1/reset
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

  def list_params
    params.require(:list).permit(:name)
    # Remova items_attributes daqui, vamos processar manualmente
  end
end