Rails.application.routes.draw do
  get "menu/tasks"
  get "menu/game"
  get "menu/minigames"
  # === Аутентификация ===
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # === Главное меню ===
  get 'dashboard', to: 'dashboard#index'
  
  # === Подменю ===
  get 'tasks_menu', to: 'menu#tasks'           # Подменю задачника
  get 'game_menu', to: 'menu#game'             # Подменю игры на двоих
  get 'minigames_menu', to: 'menu#minigames'   # Подменю мини-игр
  
  # === Задачник ===
  get 'tasks/normal', to: 'tasks#normal'       # Обычный режим
  get 'tasks/horror', to: 'tasks#horror'       # Хоррор-режим
  
  # === Игра на двоих ===
  get 'game/local', to: 'games#local'          # На одном устройстве
  get 'game/online', to: 'games#online'        # На двух устройствах
  
  # === Мини-игры ===
  get 'minigames/tictactoe', to: 'minigames#tictactoe'
  get 'minigames/hangman', to: 'minigames#hangman'
  get 'minigames/sudoku', to: 'minigames#sudoku'
  
  # === Корень сайта ===
  root 'sessions#new'
end