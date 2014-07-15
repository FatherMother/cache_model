require './lib/queries_handler.rb'

if (ARGV.size == 4) && (ARGV[0] == "-f") && (ARGV[2] == "-t")	# проверяем синтаксис команды пользователя
	path_to_file = ARGV[1]                                  # сохраняем путь к файлу и подгружаем его
	life_time = ARGV[3].to_f
	file = File.readlines(path_to_file)
else
	puts "Syntax Error"                                     
	exit
end

new_handler = QueriesHandler.new(file, life_time)		# выводим результаты работы

puts new_handler.take_a_queries_count 
puts new_handler.take_a_queries_uniq_count 
puts new_handler.take_a_max_size
puts new_handler.take_a_hit_ratio


