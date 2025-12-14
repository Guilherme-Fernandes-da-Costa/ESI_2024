# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :require_login
  # CORREÇÃO: Adicione :share e :unshare
  before_action :set_list, only: %i[show edit update destroy reset share unshare]

  # GET /lists
  def index
    # Mostra listas do usuário (como owner) + listas compartilhadas
    @owned_lists = current_user.owned_lists
    @shared_lists = current_user.shared_lists
  end

  # GET /lists/new
  def new
    @list = List.new
    # NÃO crie itens automaticamente - formulário começa vazio
  end

  def show
    @items = @list.items

    @available_tags = @items.pluck(:tag).compact.uniq || []

    case params[:order]
    when "agrupar"
      @items = @items.grouped_by_tag
    when "desagrupar"
      @items = @items.order(created_at: :asc)
    when *@available_tags
      @items = @items.where(tag: params[:order])
    else
      @items = @items.order(created_at: :asc)
    end

    # Calcular o total estimado: soma de (quantity * preco) para todos os itens
    @total_estimado = @items.sum("quantity * preco")
  end

  # POST /lists
  def create
    @list = List.new(list_params.except(:items_attributes))
    @list.owner = current_user

    # Adiciona itens apenas se existirem parâmetros
    if params[:list][:items_attributes]
      params[:list][:items_attributes].each do |index, item_attrs|
        next if item_attrs[:name].blank? # Ignora itens sem nome

        item = @list.items.build(item_attrs.permit(:name, :quantity, :preco, :tag))
        item.added_by = current_user
      end
    end

    if @list.save
      redirect_to lists_path, notice: "Lista criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /lists/1/edit
  def edit
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      redirect_to @list, notice: "Lista atualizada com sucesso."
    else
      render :edit
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
    redirect_to lists_url, notice: "Lista excluída com sucesso."
  end

  def share
    user_email = params[:email].to_s.strip.downcase

    # Verificar se é o próprio usuário
    if user_email == current_user.email
      redirect_to edit_list_path(@list), alert: "Você não pode compartilhar a lista consigo mesmo."
      return
    end

    # Buscar usuário pelo email
    user = User.find_by(email: user_email)

    if user.nil?
      redirect_to edit_list_path(@list), alert: "Usuário com email '#{user_email}' não encontrado."
    elsif @list.shared_users.include?(user)
      redirect_to edit_list_path(@list), alert: "Lista já está compartilhada com este usuário."
    else
      # Criar o compartilhamento
      @list.shared_users << user
      redirect_to edit_list_path(@list), notice: "Lista compartilhada com #{user.email}."
    end
  end

  # DELETE /lists/:id/unshare
  def unshare
    user = User.find(params[:user_id])

    if @list.shared_users.include?(user)
      @list.shared_users.delete(user)
      redirect_to edit_list_path(@list), notice: "Acesso removido de #{user.email}."
    else
      redirect_to edit_list_path(@list), alert: "Usuário não tem acesso a esta lista."
    end
  end

  # POST /lists/1/reset
  def reset
    begin
      # Verificar permissão mais cedo para dar feedback melhor
      unless @list.owner == current_user
        redirect_to @list, alert: "Apenas o dono da lista pode reiniciá-la."
        return
      end

      @list.reset!(by: current_user)

      respond_to do |format|
        format.html {
          redirect_to @list,
          notice: "Lista reiniciada com sucesso. Todos os itens foram marcados como não comprados."
        }
        format.json { render json: { success: true }, status: :ok }
      end
    rescue List::PermissionDenied
      respond_to do |format|
        format.html {
          redirect_to @list,
          alert: "Você não tem permissão para reiniciar esta lista. Apenas o dono pode realizar esta ação."
        }
        format.json { render json: { error: "Falta de permissão" }, status: :forbidden }
      end
    rescue StandardError => e
      Rails.logger.error "Erro ao resetar lista #{@list.id}: #{e.message}"
      respond_to do |format|
        format.html {
          redirect_to @list,
          alert: "Não foi possível reiniciar a lista. Erro: #{e.message}"
        }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_list
    if params[:id].present?
      @lista = List.find(params[:id])
    else
      @lista = current_list
    end
    @list = @lista
  end

  def list_params
    params.require(:list).permit(
      :name,
      items_attributes: [ :id, :name, :quantity, :preco, :tag, :quantidade_comprada, :_destroy ]
    )
  end
end
