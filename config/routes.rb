Rails.application.routes.draw do
  # === Аутентификация ===
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # === Главное меню ===
  get "dashboard", to: "dashboard#index"

  # === Подменю ===
  get "game_menu", to: "menu#game"
  get "minigames_menu", to: "menu#minigames"

  # === ЗАДАЧНИК ===
  get "tasks/menu", to: "tasks#menu", as: "tasks_menu"

  resources :task_levels, only: [] do
    resources :task_types, only: [ :index ] do
      resources :tasks, only: [ :show ] do
        post "attempt", on: :member
      end
    end
  end

  # === Игра на двоих: выбор режима ===
  get "game/local/modes", to: "menu#local_modes"
  get "game/online/modes", to: "menu#online_modes"

  # === Игровые режимы (пока заглушки) ===
  get "game/local/normal", to: "games#local_normal"
  get "game/local/horror", to: "games#local_horror"
  get "game/online/normal", to: "games#online_normal"
  get "game/online/horror", to: "games#online_horror"

  # === Мини-игры ===
  get "minigames/tictactoe", to: "minigames#tictactoe"
  get "minigames/hangman", to: "minigames#hangman"
  get "minigames/sudoku", to: "minigames#sudoku"

  # === Корень сайта ===
  root "sessions#new"
end
