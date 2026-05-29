class MinigamesController < ApplicationController
  # Подключаем библиотеку (гем)
  require 'Go_Game_Gem'

  # === КРЕСТИКИ-НОЛИКИ ===

  def tictactoe
    unless session[:ttt_board]
      session[:ttt_board] = Array.new(9)
      session[:ttt_player] = 'X'
      session[:ttt_winner] = nil
      session[:ttt_over] = false
    end

    @board = session[:ttt_board]
    @player = session[:ttt_player]
    @winner = session[:ttt_winner]
    @game_over = session[:ttt_over]
  end

  def tictactoe_move
    pos = params[:position].to_i
    
    return redirect_to minigames_tictactoe_path if session[:ttt_over] || session[:ttt_board][pos]

    session[:ttt_board][pos] = session[:ttt_player]

    wins = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    if wins.any? { |a,b,c| session[:ttt_board][a] == session[:ttt_player] &&
                           session[:ttt_board][b] == session[:ttt_player] &&
                           session[:ttt_board][c] == session[:ttt_player] }
      session[:ttt_winner] = session[:ttt_player]
      session[:ttt_over] = true
    elsif session[:ttt_board].all?
      session[:ttt_over] = true
    else
      session[:ttt_player] = (session[:ttt_player] == 'X' ? 'O' : 'X')
    end

    redirect_to minigames_tictactoe_path
  end

  def tictactoe_reset
    session.delete(:ttt_board)
    session.delete(:ttt_player)
    session.delete(:ttt_winner)
    session.delete(:ttt_over)
    redirect_to minigames_tictactoe_path
  end

  # === ВИСЕЛИЦА ===

  def hangman
    # 1. Создаем объект игры из гема (выполняем требование проекта)

    # 2. Инициализируем игру в сессии, если её нет
    unless session[:hangman_word]
      words = ["ПРОГРАММА", "КОМПЬЮТЕР", "РОССИЯ", "МОСКВА", "АЛГОРИТМ", "ВЕБСАЙТ", "РЕЛЬСЫ", "ИНТЕРНЕТ"]
      session[:hangman_word] = words.sample
      session[:hangman_guessed] = []
      session[:hangman_mistakes] = 0
      session[:hangman_max_mistakes] = 7
      session[:hangman_status] = "playing"
    end

    # 3. Передаем данные в view
    @word = session[:hangman_word]
    @guessed = session[:hangman_guessed] || []
    @mistakes = session[:hangman_mistakes] || 0
    @max_mistakes = session[:hangman_max_mistakes] || 7
    @status = session[:hangman_status] || "playing"
  end

  def hangman_guess
    letter = params[:letter].to_s.strip.upcase

    # Если игра окончена или буква пустая — игнорируем
    if session[:hangman_status] != "playing" || letter.empty?
      redirect_to hangman_path
      return
    end

    # Если буква уже была — игнорируем
    if session[:hangman_guessed].include?(letter)
      redirect_to hangman_path
      return
    end

    # Добавляем букву в угаданные
    session[:hangman_guessed] << letter

    # Проверяем, есть ли буква в слове
    unless session[:hangman_word].include?(letter)
      session[:hangman_mistakes] += 1
    end

    # Проверка победы: все буквы слова угаданы?
    all_guessed = session[:hangman_word].chars.all? { |char| session[:hangman_guessed].include?(char) }

    if all_guessed
      session[:hangman_status] = "won"
    elsif session[:hangman_mistakes] >= session[:hangman_max_mistakes]
      session[:hangman_status] = "lost"
    end

    redirect_to hangman_path
  end

  def hangman_reset
    session.delete(:hangman_word)
    session.delete(:hangman_guessed)
    session.delete(:hangman_mistakes)
    session.delete(:hangman_status)
    redirect_to hangman_path
  end


  def sudoku
    @gem_ref = GoGameGem::Sudoku.new if defined?(GoGameGem::Sudoku)

    unless session[:sudoku_board]
      session[:sudoku_board] = [
        [5,3,0, 0,7,0, 0,0,0], [6,0,0, 1,9,5, 0,0,0], [0,9,8, 0,0,0, 0,6,0],
        [8,0,0, 0,6,0, 0,0,3], [4,0,0, 8,0,3, 0,0,1], [7,0,0, 0,2,0, 0,0,6],
        [0,6,0, 0,0,0, 2,8,0], [0,0,0, 4,1,9, 0,0,5], [0,0,0, 0,8,0, 0,7,9]
      ]
      session[:sudoku_solution] = [
        [5,3,4, 6,7,8, 9,1,2], [6,7,2, 1,9,5, 3,4,8], [1,9,8, 3,4,2, 5,6,7],
        [8,5,9, 7,6,1, 4,2,3], [4,2,6, 8,5,3, 7,9,1], [7,1,3, 9,2,4, 8,5,6],
        [9,6,1, 5,3,7, 2,8,4], [2,8,7, 4,1,9, 6,3,5], [3,4,5, 2,8,6, 1,7,9]
      ]
      # 🔹 Инициализируем как ХЭШ (не массив!)
      session[:sudoku_user_input] = {}
      session[:sudoku_status] = "playing"
      session[:sudoku_errors] = 0
    end

    @board = session[:sudoku_board]
    @solution = session[:sudoku_solution]
    @user_input = session[:sudoku_user_input]
    @status = session[:sudoku_status]
    @errors = session[:sudoku_errors]
  end

  def sudoku_guess
    new_input = params[:sudoku]
    
    if new_input
      new_input.each do |row_str, cols|
        cols.each do |col_str, val|
          key = "#{row_str}_#{col_str}"
          if val.present?
            session[:sudoku_user_input][key] = val
          else
            session[:sudoku_user_input].delete(key)
          end
        end
      end
    end

    current_errors = 0
    game_won = true
    
    0.upto(8) do |row|
      0.upto(8) do |col|
        next if session[:sudoku_board][row][col] != 0
        
        user_val = session[:sudoku_user_input]["#{row}_#{col}"]
        correct_val = session[:sudoku_solution][row][col]
        
        if user_val.blank?
          game_won = false
        elsif user_val.to_i != correct_val
          current_errors += 1
          game_won = false
        end
      end
    end

    session[:sudoku_errors] = current_errors
    session[:sudoku_status] = game_won ? "won" : "playing"
    redirect_to sudoku_path
  end

  def sudoku_reset
    session.delete(:sudoku_board)
    session.delete(:sudoku_solution)
    session.delete(:sudoku_user_input)
    session.delete(:sudoku_status)
    session.delete(:sudoku_errors)
    redirect_to sudoku_path
  end
  
end