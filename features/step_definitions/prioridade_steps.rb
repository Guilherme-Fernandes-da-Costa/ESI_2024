Dado("que existe o item {string} na lista") do |nome|
	@usuario ||= FactoryBot.create(:user)
	@lista   ||= FactoryBot.create(:list, owner: @usuario)

	@item = FactoryBot.create(:item, name: nome, priority: "Baixa", list: @lista)

	visit list_path(@lista)
end

Dado("que o item {string} está com prioridade {string}") do |nome, prioridade|
	@usuario ||= FactoryBot.create(:user)
	@lista   ||= FactoryBot.create(:list, owner: @usuario)

	@item = FactoryBot.create(:item, name: nome, priority: prioridade, list: @lista)

	visit list_path(@lista)
end

Quando("eu defino a prioridade do item {string} como {string}") do |nome, prioridade|
	item = @lista.items.find_by(name: nome)

	within "#item_#{item.id}" do
		select prioridade, from: "Prioridade"
		click_button "Salvar"
	end
end

Quando("eu mudo a prioridade do item {string} para {string}") do |nome, prioridade|
	item = @lista.items.find_by(name: nome)

	within "#item_#{item.id}" do
		select prioridade, from: "Prioridade"
		click_button "Salvar"
	end
end

Então("o item {string} deve aparecer como prioridade {string}") do |nome, prioridade|
	expect(page).to have_content "#{nome}"
	expect(page).to have_content "Prioridade: #{prioridade}"
end