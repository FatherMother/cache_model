# encoding: utf-8
require "unicode"

class QueriesHandler
=begin
Инициализирует все необходимые параметры:
	file - файл с запросами
	life_time - время хранения кэша
	queries_total - общеее кол-во запросов
	queries_uniq - кол-во уникальных запросов
	сache_hit - кол-во попаданий в кэш
	query - хэш, для хранения запросов в качестве ключа и кол-во повторений в значении. Используется 		для подсчета кол-ва уникальных записей
	q_dates - хэш, для хранения уникальных записей и их дат созданий. Используется для поиска записей 		попавших в кэш 
	all_queries_date_time - массив, для хранения всех дат создания записей. Используется для расчета 		максимального размера кэша
	cache_max_size - максимальный размер кэша
	cache_hit_ratio - процент попаданий в кэш
=end
	def initialize(file, life_time)
		@file = file
		@life_time = life_time
		@queries_total = 0
		@queries_uniq = 0
		@сache_hit = 0
		@query = Hash.new(0)
		@q_dates = Hash.new(0)
		@all_queries_date_time = []
		@cache_max_size = 0
		@cache_hit_ratio = 0
		
	end

	private
=begin
	calc_queries_count - обрабатывает файл с запросами и подсчитывает кол-во записей. Подготавливает 		данные для дальнейших подсчетов
	calc_queries_uniq - считает кол-во уникальных записей
	calc_max_size - расчитывает максимальный размер кэша
	calc_hit_ratio - расчитывает процент попаданий в кэш
=end
	def calc_queries_count
		@file.each do |item|                                            
			if item.split.size >= 3
				@queries_total += 1
				item = Unicode::downcase(item)
				date = item.split[0]                           
				time = item.split[1] 
				date_time = Time.local(date.split(".")[2].to_i, date.split(".")[1].to_i, date.split(".")[0].to_i, time.split(".")[0].to_i, time.split(".")[1].to_i, time.split(".")[2].to_i)   
				text = item.scan(/[а-я]+|[a-z]+/).join(" ")     
				@all_queries_date_time << date_time 
				if !@query.key?(text)                                     
	        			@query[text] += 1
					@q_dates[text] = date_time
				else 
					if (date_time - @q_dates[text]) < @life_time
						@query[text] += 1
						@q_dates[text] = date_time
						@сache_hit += 1 
					else
						@q_dates[text] = date_time              			
					end
				end
			end
		end
		return @queries_total
	end

	def calc_queries_uniq
		@queries_uniq = @query.size
		return @queries_uniq
	end


	def calc_max_size
		count = 0
		current_date = nil
		@all_queries_date_time.each do |date|
			if current_date == nil
				current_date = date
			end
			if date - current_date < @life_time
				count += 1
			else
				if @cache_max_size < count
					@cache_max_size = count
				end
				current_date = date
				count = 0
			end
			if @cache_max_size < count
				@cache_max_size = count
			end		
		end	
		return @cache_max_size
	end

	def calc_hit_ratio
		return @cache_hit_ratio = @сache_hit.to_f / @queries_total.to_f   
	end
	
	public
=begin
	api для работы с классом
=end	
	def take_a_queries_count
		return calc_queries_count
	end

	def take_a_queries_uniq_count
		return calc_queries_uniq
	end

	def take_a_max_size
		return calc_max_size
	end

	def take_a_hit_ratio
		return calc_hit_ratio
	end
end
