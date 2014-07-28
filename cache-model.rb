# encoding: utf-8
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

puts "Queries total: " + new_handler.take_a_queries_count.to_s 
puts "Queries uniq: " + new_handler.take_a_queries_uniq_count.to_s 
puts "Cache max size: " + new_handler.take_a_max_size.to_s
puts "Cache hit ratio: " + new_handler.take_a_hit_ratio.to_s


