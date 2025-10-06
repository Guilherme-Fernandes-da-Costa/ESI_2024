Given("que {string} é um organizador") do |usuario|
    @usuario_atual = usuario
    @organizador = true
end

Given("que {string} não é um organizador") do |usuario|
    @usuario_atual = usuario
    @organizador = true
end

Quando("{string} reinicia a lista") do |usuario|
    visit "/lista"
    if @organizador
        click_button "Reiniciar lista"
    else
        page.execute_script("alert('Permissão negada!')")
    end
end

Quando("{string} tenta reiniciar a lista") do |usuario|
    visit "/lista"
    unless @organizador
        page.execute_script("alert('Permissão negada!')")
    end
end

Então("a lista deve estar vazia") do
    expect(page).to have_no_css("li")
end 

Então("a operação deve ser negada") do
    expect(@organizador).to be false
end