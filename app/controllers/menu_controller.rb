class MenuController < ApplicationController
  before_action :require_login
  
  def tasks
    # Подменю задачника
  end
  
  def game
    # Подменю игры на двоих
  end
  
  def minigames
    # Подменю мини-игр
  end
end