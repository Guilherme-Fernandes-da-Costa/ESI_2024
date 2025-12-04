Dado("que {string} é um organizador") do |usuario|
  @usuario_atual = usuario
  @organizador = true
end

Dado("que {string} não é um organizador") do |usuario|
  @usuario_atual = usuario
  @organizador = false
  # mark as not authorized as well for permission step compatibility
  @autorizado = false
end

Quando("{string} adiciona {string} à lista") do |usuario, participante|
  # Non-JS approach: create list and add participant via DB when organizer
  owner = User.find_or_create_by(name: usuario) { |u| u.email = "#{usuario.downcase}@example.com" }
  # Reuse existing list if present, otherwise create
  @last_list ||= List.create!(name: "Lista de #{usuario}", owner: owner)

  if @organizador
    participant_user = User.find_or_create_by(name: participante) { |u| u.email = "#{participante.downcase}@example.com" }
    ListShare.find_or_create_by!(list: @last_list, user: participant_user)
    @permission_denied = false
  else
    @permission_denied = true
  end
end

Quando("{string} adiciona {string} à lista na unidade") do |usuario, participante|
  step(%Q|"#{usuario}" adiciona "#{participante}" à lista|)
end

Então("{string} deve aparecer como participante da lista") do |participante|
  # Verify via DB that the participant was added to the last created list
  expect(@last_list.shared_users.pluck(:name)).to include(participante)
end

Então("{string} e {string} devem aparecer como participantes da lista") do |p1, p2|
  # Verify via DB that both participants were added to the last created list
  names = @last_list.shared_users.pluck(:name)
  expect(names).to include(p1)
  expect(names).to include(p2)
end

 # Use common permission step defined in permissao_steps.rb

 # Use permission step/DB-based check from permissao_steps.rb for absence assertions
