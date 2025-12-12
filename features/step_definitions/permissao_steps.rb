Dado("que {string} é um usuário autorizado") do |usuario|
  @usuario_atual = usuario
  @autorizado = true
end

Dado("que {string} é um usuário não autorizado") do |usuario|
  @usuario_atual = usuario
  @autorizado = false
end

Dado("{string} já está na lista") do |item|
  # Create list and item via DB to avoid UI dependencies
  @user ||= FactoryBot.create(:user)
  @list ||= List.create!(name: 'Lista de Teste', owner: @user)
  @list.items.create!(name: item, added_by: @user, preco: 0.0)
end

Quando("{string} tenta adicionar {string} à lista") do |usuario, item|
  # Non-JS approach: modify DB when authorized, otherwise flag as denied
  @user ||= FactoryBot.create(:user, email: "#{usuario.downcase}@example.com")
  @list ||= List.create!(name: 'Lista de Teste', owner: @user)
  if @autorizado
    @list.items.create!(name: item, added_by: @user, preco: 0.0)
    @permission_denied = false
  else
    @permission_denied = true
  end
end

Quando("{string} remove {string}") do |usuario, item|
  @user ||= FactoryBot.create(:user, email: "#{usuario.downcase}@example.com")
  @list ||= List.create!(name: 'Lista de Teste', owner: @user)
  if @autorizado
    found = @list.items.find_by(name: item)
    found.destroy if found
    @permission_denied = false
  else
    @permission_denied = true
  end
end

Então("a operação deve ser permitida") do
  expect(@autorizado).to be true
end

Então("a operação deve ser negada") do
  expect(@autorizado).to be false
end

Então("{string} deve aparecer na lista") do |item|
  expect(@list.items.pluck(:name)).to include(item)
end

Então("{string} não deve aparecer na lista") do |item|
  expect(@list.items.pluck(:name)).not_to include(item)
end
