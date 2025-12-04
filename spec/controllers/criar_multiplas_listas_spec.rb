
require 'rails_helper'

RSpec.describe "Gerenciamento de Múltiplas Listas", type: :system do
  before do
    driven_by(:rack_test)
  end


  describe "Criar nova lista" do
    it "permite criar uma nova lista e dar um nome a ela" do
      visit "/lista"

      expect(page).to have_button("Criar nova lista")

      click_button "Criar nova lista"

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

      expect(page).to have_selector(".itens-lista")

      click_button "+"

      expect(page).to have_content("nome")
      expect(page).to have_content("preco")
      expect(page).to have_content("quantidade")

      fill_in "nome", with: "carne"
      fill_in "preco", with: 10.00
      fill_in "quantidade", with: 2

      click_button "Concluir"

      expect(page).to have_content("carne")
    end
  end
end
