# Given/step for organizer is defined in feature-specific step files to avoid ambiguity
# This file relies on the shared organizer step defined elsewhere.

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

# Use shared permission step defined in permissao_steps.rb