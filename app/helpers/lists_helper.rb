# app/helpers/lists_helper.rb
def can_edit_quantity?(item)
  # Permite edição se o usuário for o dono da lista ou um usuário compartilhado
  current_user == item.list.owner || item.list.shared_users.include?(current_user)
end