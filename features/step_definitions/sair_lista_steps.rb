# Given step for user is defined elsewhere to avoid ambiguous matches

# The generic "apertar no botão" step is defined in adicionar_lista_amigos_steps.rb
# to avoid ambiguous matches across friend-management step files.

Então('{string} deve ser direcionado a tela principal') do |nome|
  expect(@usuario).to eq(nome)
  expect(@lista_aberta).to be_falsey
  expect(page).to have_current_path(tela_principal_path)
end
