lines = []
File.new "queries.txt", "w"
file = File.open "queries.txt", "w"
num = ARGV[0].to_i
start_time = [0, 0, 0]
start_date = [28, 7, 2014]
start_query = ["з", "а", "п", "р", "о", "с"]

num.times {

if rand(2) == 1 
	if start_time[2] < 59 
		start_time[2] += 1 
	else
		start_time[2] = 0
		if start_time[1] < 59
			start_time[1] += 1
		else
			start_time[1] = 0
			if start_time[0] < 59
				start_time[0] += 1
			else
				start_time[0] = 0	
				if start_date[0] < 31
					start_date[0] += 1
				else
					start_date[0] = 1
					if start_date[1] < 12
						start_date[1] += 1
					else
						start_date[1] = 1
						start_date[2] += 1
					end
				end
			end
		end
	end
	
end
date = start_date * "." 
time = start_time * "."
query = start_query.sort_by{rand} * ""
	

file.puts date + " " +  time + " " + query

}
