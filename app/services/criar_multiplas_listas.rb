class CriarMultiplasListas
  # Serviço placeholder para criação de múltiplas listas.
  # Implementação mínima para satisfazer o autoloader (Zeitwerk) durante testes/CI.

  def initialize(user:, count: 1)
    @user = user
    @count = count.to_i
  end

  def call
    created = []
    @count.times do |i|
      created << List.create!(name: "Lista ##{i + 1}", owner: @user)
    end
    created
  end
end
