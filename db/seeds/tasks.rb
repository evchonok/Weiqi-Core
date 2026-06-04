# db/seeds/tasks.rb
puts "🌱 Загружаю задачи по уровням..."
TaskType.where(name: "Эндшпиль").destroy_all

# ==========================================
# УРОВЕНЬ 1: НОВИЧОК
# ==========================================
level1 = TaskLevel.find_or_create_by!(name: "Новичок") do |l|
  l.difficulty = 1
  l.description = "Базовые задачи: жизнь, смерть, простые формы"
end

type1_l1 = TaskType.find_or_create_by!(task_level: level1, name: "Жизнь и смерть") do |t|
  t.instructions = "Сделай группу живой или убей врага"
end

type2_l1 = TaskType.find_or_create_by!(task_level: level1, name: "Тесудзи") do |t|
  t.instructions = "Найди красивый тактический удар"
end

# Очищаем старые задачи этого типа
Task.where(task_type: type1_l1).destroy_all

# 1. Новичок - Жизнь и смерть

Task.find_or_create_by!(task_type: type1_l1, solution: "E5") do |t|
  t.board_state = {
    "1,6" => "black", "3,6" => "black", "4,6" => "black", "5,6" => "black", "6,6" => "black",
    "2,5" => "black", "7,5" => "black",
    "1,4" => "black", "7,4" => "black",
    "1,3" => "black", "7,3" => "black",
    "2,2" => "black", "3,2" => "black", "4,2" => "black", "5,2" => "black", "6,2" => "black",
    "3,5" => "white", "4,5" => "white", "5,5" => "white", "6,5" => "white",
    "2,4" => "white", "6,4" => "white",
    "3,3" => "white", "6,3" => "white",
    "3,2" => "white", "4,2" => "white", "5,2" => "white", "6,2" => "white"
  }.to_json
  t.solution = "E5"
  t.time_limit_sec = 60
  t.points = 15
  t.horror_enabled = true
  t.hint = "Займи центральный пункт для создания двух глаз"
end

Task.find_or_create_by!(task_type: type1_l1, solution: "A1") do |t|
  t.board_state = {
    "0,3" => "black", "1,3" => "black", "2,3" => "black", "3,3" => "black",
    "4,0" => "black", "4,1" => "black", "4,2" => "black",
    "0,2" => "white",
    "1,2" => "white", "1,1" => "white",
    "2,1" => "white", "2,0" => "white"
  }.to_json
  t.time_limit_sec = 45
  t.points = 10
  t.horror_enabled = true
  t.hint = "Защитись сверху, чтобы создать пространство для глаз"
end

Task.find_or_create_by!(task_type: type1_l1, solution: "Q16") do |t|
  t.board_state = {
    "13,17" => "black", "14,17" => "black", "15,17" => "black", "16,17" => "black",
    "12,16" => "black", "17,16" => "black",
    "12,15" => "black",
    "12,14" => "black", "13,13" => "black", "14,13" => "black", "15,13" => "black", "16,13" => "black", "17,13" => "black",
    "14,16" => "white", "15,16" => "white", "16,16" => "white",
    "13,15" => "white", "17,15" => "white",
    "14,14" => "white", "15,14" => "white", "16,14" => "white", "17,14" => "white"
  }.to_json
  t.time_limit_sec = 90
  t.points = 20
  t.horror_enabled = true
  t.hint = "Найди ключевой пункт для расширения пространства"
end


Task.find_or_create_by!(task_type: type1_l1, solution: "S2") do |t|
  t.board_state = {
    # Чёрные
    "16,0" => "black", "16,1" => "black", "16,2" => "black", "16,3" => "black", "17,3" => "black", "18,2" => "black",
    # Белые
    "15,1" => "white", "15,2" => "white", "15,3" => "white", "15,4" => "white", "16,4" => "white",
    "17,4" => "white", "18,4" => "white", "18,3" => "white"
  }.to_json
  t.time_limit_sec = 45
  t.points = 10
  t.horror_enabled = true
  t.hint = "Важный пункт для захвата или спасения"
end

Task.find_or_create_by!(task_type: type2_l1, solution: "G5") do |t|
  t.board_state = {
    "5,1" => "white", "5,2" => "white", "7,4" => "white", "7,5" => "white", "6,5" => "white",
    "6,2" => "black", "7,2" => "black", "5,3" => "black",
    "4,4" => "black", "4,5" => "black"
  }.to_json
  t.time_limit_sec = 60
  t.points = 20
  t.horror_enabled = true
  t.hint = "Постройте хорошую форму"
end

Task.find_or_create_by!(task_type: type2_l1, solution: "A17") do |t|
  t.board_state = {
    # Белые
    "0,14" => "white", "1,14" => "white", "2,14" => "white", "3,14" => "white",
    "3,15" => "white", "2,16" => "white", "2,17" => "white", "1,17" => "white", "0,17" => "white",
    # Чёрные
    "1,15" => "black", "2,15" => "black", "3,16" => "black", "3,17" => "black",
    "3,18" => "black", "2,18" => "black", "1,18" => "black"
  }.to_json
  t.time_limit_sec = 60
  t.points = 15
  t.horror_enabled = true
  t.hint = "Ключевая точка для соединения или отсечения"
end


Task.find_or_create_by!(task_type: type2_l1, solution: "T4") do |t|
  t.board_state = {
    # Белые
    "15,2" => "white", "16,2" => "white", "17,2" => "white", "18,2" => "white",
    "14,3" => "white", "14,4" => "white", "14,5" => "white", "15,5" => "white",
    "16,5" => "white", "17,6" => "white", "16,7" => "white", "18,7" => "white", "18,5" => "white",
    # Чёрные
    "14,1" => "black", "15,1" => "black", "16,1" => "black", "17,1" => "black", "18,1" => "black",
    "14,2" => "black", "15,3" => "black", "15,4" => "black", "16,4" => "black",
    "17,4" => "black", "17,5" => "black"
  }.to_json
  t.time_limit_sec = 60
  t.points = 15
  t.horror_enabled = true
  t.hint = "Удар по форме соперника"
end


# ==========================================
# УРОВЕНЬ 2: ПРОДВИНУТЫЙ (СРЕДНИЙ)
# ==========================================
level2 = TaskLevel.find_or_create_by!(name: "Продвинутый") do |l|
  l.difficulty = 5
  l.description = "Задачи средней сложности"
end

type1_l2 = TaskType.find_or_create_by!(task_level: level2, name: "Жизнь и смерть") do |t|
  t.instructions = "Сделай группу живой или убей врага"
end
type2_l2 = TaskType.find_or_create_by!(task_level: level2, name: "Тесудзи") do |t|
  t.instructions = "Найди красивый тактический удар"
end

Task.where(task_type: type1_l2).destroy_all
Task.where(task_type: type2_l2).destroy_all

# 2. Продвинутый - Жизнь и смерть
Task.find_or_create_by!(task_type: type1_l2, solution: "S1") do |t|
  t.board_state = {
    # Белые
    "14,0" => "white", "14,1" => "white", "15,1" => "white", "16,1" => "white", "16,2" => "white",
    "16,3" => "white", "17,3" => "white", "18,3" => "white",
    # Чёрные
    "13,1" => "black", "13,2" => "black", "15,3" => "black", "15,4" => "black", "16,4" => "black",
    "17,4" => "black", "16,0" => "black", "17,1" => "black", "18,1" => "black"
  }.to_json
  t.time_limit_sec = 60
  t.points = 20
  t.horror_enabled = true
  t.hint = "Ключевая точка на первой линии"
end

# 3. Продвинутый - Жизнь и смерть
Task.find_or_create_by!(task_type: type1_l2, solution: "A2") do |t|
  t.board_state = {
    # Белые
    "1,0" => "white", "1,1" => "white", "1,2" => "white", "1,3" => "white", "0,3" => "white",
    "2,2" => "white", "2,3" => "white", "3,2" => "white", "4,1" => "white", "4,0" => "white",
    # Чёрные
    "0,2" => "black", "0,4" => "black", "1,4" => "black", "2,4" => "black", "3,4" => "black",
    "3,3" => "black", "4,2" => "black", "5,2" => "black", "5,1" => "black", "5,0" => "black",
    "2,1" => "black", "3,1" => "black"
  }.to_json
  t.time_limit_sec = 75
  t.points = 25
  t.horror_enabled = true
  t.hint = "Узкое место в углу"
end

# 4. Продвинутый - Тесудзи
Task.find_or_create_by!(task_type: type2_l2, solution: "S14") do |t|
  t.board_state = {
    # Белые
    "15,10" => "white", "16,10" => "white", "16,11" => "white", "17,11" => "white",
    "15,12" => "white", "15,13" => "white", "15,14" => "white", "17,14" => "white",
    "16,15" => "white", "17,15" => "white", "14,15" => "white", "13,16" => "white",
    "14,16" => "white", "15,16" => "white", "13,17" => "white", "14,17" => "white",
    # Чёрные
    "14,11" => "black", "14,12" => "black", "14,13" => "black", "14,14" => "black", "14,15" => "black",
    "15,15" => "black", "16,14" => "black", "18,15" => "black", "16,16" => "black",
    "16,17" => "black", "15,17" => "black", "17,16" => "black"
  }.to_json
  t.time_limit_sec = 90
  t.points = 30
  t.horror_enabled = true
  t.hint = "Тактический удар в центре формы"
end

# 5. Продвинутый - Тесудзи
Task.find_or_create_by!(task_type: type2_l2, solution: "S16") do |t|
  t.board_state = {
    # Белые
    "15,12" => "white", "16,12" => "white", "17,12" => "white", "18,12" => "white",
    "13,13" => "white", "14,14" => "white", "15,14" => "white", "16,15" => "white",
    "14,15" => "white", "15,16" => "white",
    # Чёрные
    "14,13" => "black", "15,13" => "black", "16,13" => "black", "17,13" => "black",
    "15,15" => "black", "16,16" => "black", "14,17" => "black", "15,17" => "black", "16,17" => "black"
  }.to_json
  t.time_limit_sec = 90
  t.points = 30
  t.horror_enabled = true
  t.hint = "Прорыв или соединение?"
end

# 6. Продвинутый - Тесудзи
Task.find_or_create_by!(task_type: type2_l2, solution: "S5") do |t|
  t.board_state = {
    # Белые
    "16,1" => "white", "17,1" => "white", "15,2" => "white", "15,3" => "white",
    "16,3" => "white", "17,3" => "white", "13,3" => "white", "11,3" => "white",
    "17,5" => "white", "17,6" => "white", "16,6" => "white", "15,6" => "white",
    # Чёрные
    "18,1" => "black", "16,2" => "black", "17,2" => "black", "18,3" => "black",
    "16,4" => "black", "16,5" => "black", "14,4" => "black", "13,4" => "black",
    "14,6" => "black", "14,7" => "black", "16,8" => "black", "17,9" => "black"
  }.to_json
  t.time_limit_sec = 90
  t.points = 30
  t.horror_enabled = true
  t.hint = "Удар по слабому месту"
end


# ==========================================
# УРОВЕНЬ 3: МАСТЕР
# ==========================================
level3 = TaskLevel.find_or_create_by!(name: "Мастер") do |l|
  l.difficulty = 10
  l.description = "Сложные задачи для опытных"
end

type1_l3 = TaskType.find_or_create_by!(task_level: level3, name: "Жизнь и смерть") do |t|
  t.instructions = "Сделай группу живой или убей врага"
end
type2_l3 = TaskType.find_or_create_by!(task_level: level3, name: "Тесудзи") do |t|
  t.instructions = "Найди красивый тактический удар"
end

Task.where(task_type: type1_l3).destroy_all
Task.where(task_type: type2_l3).destroy_all

# 7. Мастер - Жизнь и смерть
Task.find_or_create_by!(task_type: type1_l3, solution: "C1") do |t|
  t.board_state = {
    # Чёрные
    "1,0" => "black", "2,1" => "black", "1,2" => "black", "1,3" => "black", "2,4" => "black",
    "3,4" => "black", "3,3" => "black", "3,2" => "black", "4,2" => "black", "4,1" => "black", "5,0" => "black",
    # Белые
    "0,1" => "white", "0,2" => "white", "0,3" => "white", "1,4" => "white", "1,5" => "white",
    "2,5" => "white", "3,5" => "white", "4,5" => "white", "4,4" => "white", "4,3" => "white",
    "5,2" => "white", "5,1" => "white", "6,0" => "white", "7,0" => "white", "3,0" => "white", "3,1" => "white"
  }.to_json
  t.time_limit_sec = 120
  t.points = 50
  t.horror_enabled = true
  t.hint = "Жизненно важный пункт (Vital point)"
end

# 8. Мастер - Жизнь и смерть
Task.find_or_create_by!(task_type: type1_l3, solution: "D1") do |t|
  t.board_state = {
    # Чёрные
    "1,0" => "black", "0,1" => "black", "1,2" => "black", "2,2" => "black", "3,2" => "black",
    "4,1" => "black", "4,0" => "black",
    # Белые
    "0,2" => "white", "0,3" => "white", "1,3" => "white", "2,3" => "white", "3,3" => "white",
    "4,2" => "white", "5,2" => "white", "6,1" => "white", "3,1" => "white", "2,0" => "white"
  }.to_json
  t.time_limit_sec = 120
  t.points = 50
  t.horror_enabled = true
  t.hint = "Первая линия решает"
end

# 9. Мастер - Тесудзи
Task.find_or_create_by!(task_type: type2_l3, solution: "A3") do |t|
  t.board_state = {
    # Белые
    "0,0" => "white", "1,1" => "white", "2,1" => "white", "4,0" => "white", "4,1" => "white",
    "4,2" => "white", "3,3" => "white", "3,4" => "white", "2,4" => "white", "1,4" => "white", "0,4" => "white",
    # Чёрные
    "2,0" => "black", "3,0" => "black", "3,1" => "black", "3,2" => "black", "2,2" => "black",
    "2,3" => "black", "1,3" => "black"
  }.to_json
  t.time_limit_sec = 120
  t.points = 50
  t.horror_enabled = true
  t.hint = "Хитрый ход в углу"
end

# 10. Мастер - Тесудзи
Task.find_or_create_by!(task_type: type2_l3, solution: "S2") do |t|
  t.board_state = {
    # Белые
    "14,0" => "white", "14,1" => "white", "14,2" => "white", "15,2" => "white", "16,2" => "white",
    "17,3" => "white", "18,2" => "white",
    # Чёрные
    "13,0" => "black", "13,1" => "black", "13,2" => "black", "13,3" => "black", "14,3" => "black",
    "15,3" => "black", "16,3" => "black", "17,4" => "black", "18,4" => "black", "15,0" => "black", "18,0" => "black"
  }.to_json
  t.time_limit_sec = 120
  t.points = 50
  t.horror_enabled = true
  t.hint = "Тактический размен"
end

puts "✅ Готово! Загружено:"
puts "  - #{TaskLevel.count} уровней"
puts "  - #{TaskType.count} типов задач"
puts "  - Всего задач: #{Task.count}"
