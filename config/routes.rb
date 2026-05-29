Rails.application.routes.draw do
  # === Аутентификация ===
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # === Главное меню ===
  get 'dashboard', to: 'dashboard#index'
  
  # === Подменю ===
  get 'tasks_menu', to: 'menu#tasks'
  get 'game_menu', to: 'menu#game'
  get 'minigames_menu', to: 'menu#minigames'
  
  # === Задачник ===
  get 'tasks/normal', to: 'tasks#normal'
  get 'tasks/horror', to: 'tasks#horror'
  
  # === Игра на двоих: выбор режима ===
  get 'game/local/modes', to: 'menu#local_modes'
  get 'game/online/modes', to: 'menu#online_modes'
  
  # === Игровые режимы (пока заглушки) ===
  get 'game/local/normal', to: 'games#local_normal'
  get 'game/local/horror', to: 'games#local_horror'
  get 'game/online/normal', to: 'games#online_normal'
  get 'game/online/horror', to: 'games#online_horror'
  
  # === Мини-игры ===
  get 'minigames/tictactoe', to: 'minigames#tictactoe'
  post 'minigames/tictactoe', to: 'minigames#tictactoe_move'
  delete 'minigames/tictactoe', to: 'minigames#tictactoe_reset'
  get 'minigames/hangman', to: 'minigames#hangman', as: 'hangman'
  post 'minigames/hangman/guess', to: 'minigames#hangman_guess', as: 'hangman_guess'
  delete 'minigames/hangman', to: 'minigames#hangman_reset'
  get 'minigames/sudoku', to: 'minigames#sudoku', as: 'sudoku'
  post 'minigames/sudoku/guess', to: 'minigames#sudoku_guess', as: 'sudoku_guess'
  delete 'minigames/sudoku', to: 'minigames#sudoku_reset'
  
  # === Корень сайта ===
  root 'sessions#new'
end