# Helper utilities to map old BDD labels to current UI
module StepHelpers
  def ui_fill(field, value)
    case field.to_s.downcase
    when /nome da lista/, /nome$/
      fill_in 'list_name', with: value
    when /nome do item/, /novo item/, /nome do item \*/
      fill_in 'item_name', with: value
    else
      fill_in field, with: value
    end
  end

  def ui_click(text)
    # Try exact matches first
    return click_button(text) if page.has_button?(text)
    return click_link(text) if page.has_link?(text)

    # common fallbacks
    if text =~ /reiniciar/i && page.has_button?('🔄 Reiniciar Lista')
      return click_button('🔄 Reiniciar Lista')
    end

    if text =~ /nova lista|criar/i
      # prefer explicit new_list_path link if present
      begin
        el = find_link(href: new_list_path)
        el.click
        return
      rescue Capybara::ElementNotFound, StandardError
        # fallback to other strategies
      end
    end

    # last resort: click on any element containing the text
    click_on(text) rescue raise "Could not find button/link '#{text}'"
  end
end

World(StepHelpers)
