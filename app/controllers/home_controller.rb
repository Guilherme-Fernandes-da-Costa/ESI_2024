class HomeController < ApplicationController
  def index
    render plain: "OK" # simples resposta 200; você pode alterar para renderizar view
  end
end
