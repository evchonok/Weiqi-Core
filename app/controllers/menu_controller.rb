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

    def local_modes
  end

  def online_modes
  end
end