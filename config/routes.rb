Rails.application.routes.draw do
  # Аутентификация
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Главное меню
  get "dashboard", to: "dashboard#index"

  # Подменю
  get "game_menu", to: "menu#game"
  get "minigames_menu", to: "menu#minigames"
  get "tasks/menu", to: "tasks#menu", as: "tasks_menu"

  # Задачник
  resources :task_levels, only: [] do
    resources :task_types, only: [:index] do
      resources :tasks, only: [:index, :show] do
        post "attempt", on: :member
        get "random", on: :collection
      end
    end
  end

  # Игра на двоих
  get "game/local/normal", to: "games#local_normal"
  get "game/local/horror", to: "games#local_horror"

  # Мини-игры
  get "minigames/tictactoe", to: "minigames#tictactoe"
  post "minigames/tictactoe", to: "minigames#tictactoe_move"
  delete "minigames/tictactoe", to: "minigames#tictactoe_reset"
  
  get "minigames/hangman", to: "minigames#hangman", as: "hangman"
  post "minigames/hangman/guess", to: "minigames#hangman_guess", as: "hangman_guess"
  delete "minigames/hangman", to: "minigames#hangman_reset"
  
  get "minigames/sudoku", to: "minigames#sudoku", as: "sudoku"
  post "minigames/sudoku/guess", to: "minigames#sudoku_guess", as: "sudoku_guess"
  delete "minigames/sudoku", to: "minigames#sudoku_reset"

  # Корень сайта
  root "sessions#new"
end