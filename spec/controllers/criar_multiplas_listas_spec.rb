
require 'rails_helper'

RSpec.describe "Gerenciamento de Múltiplas Listas", type: :system do
  before do
    driven_by(:rack_test)
  end


  describe "Criar nova lista" do
    it "permite criar uma nova lista e dar um nome a ela" do
      visit "/lista?new=1"

      expect(page).to have_button("Criar nova lista")

      # The new-list form is rendered when ?new=1 is present
      expect(page).to have_selector(".lista")

      fill_in "Nome da lista", with: "Lista de Compras 2"
      click_button "Salvar"

      expect(page).to have_content("Lista de Compras 2")
    end
  end


  describe "Adicionar itens à lista" do
    let!(:lista) { List.create!(nome: "Lista de Compras") }

    it "permite adicionar um item à lista" do
      visit "/lista"

      click_on "Lista de Compras"

      expect(page.current_path).to match(/\/lista\/\d+/)

      # Click the link to add a new item (navigates to items#new)
      click_link "Adicionar Novo Item"

      # Use generated field ids to be robust across label text
      expect(page).to have_field('item_name')
      expect(page).to have_field('item_preco')
      expect(page).to have_field('item_quantity')

      fill_in "Nome do Item", with: "carne"
      fill_in "item_preco", with: 10.00
      fill_in "item_quantity", with: 2

      click_button "Salvar"

      expect(page).to have_content("carne")
    end
  end
end
