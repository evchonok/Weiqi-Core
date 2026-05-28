# db/seeds/tasks.rb
puts "📦 Создаю уровни задач..."

level1 = TaskLevel.find_or_create_by!(name: "Новичок") do |l|
  l.difficulty = 1
  l.description = "Простые задачи на жизнь и смерть"
end

level2 = TaskLevel.find_or_create_by!(name: "Продвинутый") do |l|
  l.difficulty = 5
  l.description = "Тесудзи и эндшпиль"
end

level3 = TaskLevel.find_or_create_by!(name: "Мастер") do |l|
  l.difficulty = 10
  l.description = "Сложные комбинации"
end

puts "📂 Создаю типы задач..."

# Типы для новичка
type1 = TaskType.find_or_create_by!(task_level: level1, name: "Жизнь и смерть") do |t|
  t.instructions = "Сделай группу живой или убей врага"
  t.icon_url = "/assets/icons/life_death.png"
end

type2 = TaskType.find_or_create_by!(task_level: level1, name: "Атака") do |t|
  t.instructions = "Атакуй слабую группу противника"
  t.icon_url = "/assets/icons/attack.png"
end

# Типы для продвинутого
type3 = TaskType.find_or_create_by!(task_level: level2, name: "Тесудзи") do |t|
  t.instructions = "Найди красивый тактический удар"
  t.icon_url = "/assets/icons/tesuji.png"
end

type4 = TaskType.find_or_create_by!(task_level: level2, name: "Эндшпиль") do |t|
  t.instructions = "Правильно заверши игру"
  t.icon_url = "/assets/icons/endgame.png"
end

puts "🧩 Создаю тестовые задачи..."

# Простая задача: спасти группу
Task.find_or_create_by!(task_type: type1, solution: "D4") do |t|
  t.board_state = {
    "3,3" => "white",
    "4,3" => "white",
    "3,4" => "white",
    "5,4" => "black",
    "4,5" => "black"
  }.to_json
  t.time_limit_sec = 60
  t.points = 10
  t.horror_enabled = true
  t.hint = "Соединись с друзьями сверху"
end

# Задача на захват
Task.find_or_create_by!(task_type: type1, solution: "E5") do |t|
  t.board_state = {
    "4,4" => "white",
    "5,4" => "white",
    "4,5" => "white",
    "6,5" => "black",
    "5,6" => "black",
    "3,5" => "black"
  }.to_json
  t.time_limit_sec = 45
  t.points = 15
  t.horror_enabled = true
  t.hint = "Атакуй слабую группу белых"
end

# Задача на тесудзи
Task.find_or_create_by!(task_type: type3, solution: "F6,E5") do |t|
  t.board_state = {
    "5,5" => "white",
    "6,5" => "white",
    "5,6" => "white",
    "7,6" => "black",
    "6,7" => "black",
    "4,6" => "black",
    "5,4" => "black"
  }.to_json
  t.time_limit_sec = 90
  t.points = 25
  t.horror_enabled = true
  t.hint = "Найди неожиданный ход"
end

puts "✅ Создано:"
puts "  - #{TaskLevel.count} уровней"
puts "  - #{TaskType.count} типов задач"
puts "  - #{Task.count} задач"
