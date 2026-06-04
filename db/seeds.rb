# db/seeds.rb
puts "🌱 Загружаем начальные данные..."
TaskType.where(name: "Атака").find_each do |type|
  type.tasks.destroy_all
  type.destroy
end
# Автоматически выполняем все файлы из папки db/seeds/
Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |file|
  puts "📄 Выполняем: #{File.basename(file)}"
  load file
end

puts "✅ Готово!"
