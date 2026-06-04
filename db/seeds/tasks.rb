# db/seeds/tasks.rb
puts "🌱 Создаю встроенные задачи (без внешних файлов)..."

# 1. Уровни
level1 = TaskLevel.find_or_create_by!(name: "Новичок") do |l|
  l.difficulty = 1
  l.description = "Базовые задачи: захват, соединение, жизнь"
end

# 2. Типы
type1 = TaskType.find_or_create_by!(task_level: level1, name: "Жизнь и смерть") do |t|
  t.instructions = "Сделай группу живой или убей врага"
end

type2 = TaskType.find_or_create_by!(task_level: level1, name: "Тесудзи") do |t|
  t.instructions = "Найди красивый тактический удар"
end

# 3. Очищаем старые задачи типа "Жизнь и смерть"
Task.where(task_type: type1).destroy_all

# === ЗАДАЧА 1: Жизнь группы в центре (9x9) ===
# Решение: E5 - ключевая точка для создания глаза
Task.find_or_create_by!(
  task_type: type1, solution: "E5") do |t|
  t.board_state = {
    # Чёрные камни (окружение)
    "1,6" => "black", "3,6" => "black", "4,6" => "black", "5,6" => "black", "6,6" => "black",
    "2,5" => "black", "7,5" => "black",
    "1,4" => "black", "7,4" => "black",
    "1,3" => "black", "7,3" => "black",
    "2,2" => "black", "3,2" => "black", "4,2" => "black", "5,2" => "black", "6,2" => "black",
    # Белые камни (группа для спасения)
    "3,5" => "white", "4,5" => "white", "5,5" => "white", "6,5" => "white",
    "2,4" => "white", "6,4" => "white",
    "3,3" => "white", "6,3" => "white",
    "3,2" => "white", "4,2" => "white", "5,2" => "white", "6,2" => "white"
  }.to_json
  t.solution = "E5" # Ключевая точка для жизни
  t.time_limit_sec = 60
  t.points = 15
  t.horror_enabled = true
  t.hint = "Займи центральный пункт для создания двух глаз"
end


Task.find_or_create_by!(
  task_type: type1, solution: "A1") do |t|
  t.board_state = {
    # Чёрные камни
    "0,3" => "black", "1,3" => "black", "2,3" => "black", "3,3" => "black",
    "4,0" => "black", "4,1" => "black", "4,2" => "black",
    # Белые камни
    "0,2" => "white",
    "1,2" => "white", "1,1" => "white",
    "2,1" => "white", "2,0" => "white"
  }.to_json
  t.time_limit_sec = 45
  t.points = 10
  t.horror_enabled = true
  t.hint = "Защитись сверху, чтобы создать пространство для глаз"
end

# Решение: Q16 - ключевой пункт
Task.find_or_create_by!(task_type: type1, solution: "P16") do |t|
  t.board_state = {
    # Чёрные камни (окружение)
    "13,17" => "black", "14,17" => "black", "15,17" => "black", "16,17" => "black",
    "12,16" => "black", "17,16" => "black",
    "12,15" => "black",
    "12,14" => "black", "13,13" => "black", "14,13" => "black", "15,13" => "black", "16,13" => "black", "17,13" => "black",
    # Белые камни (группа)
    "14,16" => "white", "15,16" => "white", "16,16" => "white",
    "13,15" => "white", "17,15" => "white",
    "14,14" => "white", "15,14" => "white", "16,14" => "white", "17,14" => "white"
  }.to_json
  t.time_limit_sec = 90
  t.points = 20
  t.horror_enabled = true
  t.hint = "Найди ключевой пункт для расширения пространства"
end


# === ЗАДАЧИ ДЛЯ ТИПА "АТАКА" ===

# Задача 4: Атака слабой группы
Task.find_or_create_by!(task_type: type2, solution: "R4") do |t|
  t.board_state = {
    "16,1" => "black", "15,2" => "black", "14,2" => "black", "16,4" => "black",
    "16,2" => "white", "15,3" => "white", "14,3" => "white", "14,5" => "black"
  }.to_json
  t.time_limit_sec = 45
  t.points = 15
  t.horror_enabled = true
  t.hint = "Соединитесь, порезав соперника"
end

# Задача 5:
Task.find_or_create_by!(task_type: type2, solution: "G5") do |t|
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

puts "✅ Готово! Загружено:"
puts "  - #{TaskLevel.count} уровней"
puts "  - #{TaskType.count} типов задач"
puts "  - #{Task.where(task_type: type1).count} задач 'Жизнь и смерть'"
puts "  - #{Task.where(task_type: type2).count} задач 'Атака'"
