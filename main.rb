
repl = -> prompt do
  # puts qs[:"Does it prey on other animals?"][:"mouse"]
  print "are two mice equal? "
  puts qs.values[0].keys[0] === qs.values[1].keys[0]

  print "does a mouse equal a trout? "
  puts qs.values[0].keys[0] === qs.values[1].keys[2]
end


class Guessing
	def initialize()
		@qs = {
			:"Does it have hair?"             => { :"mouse" => true,  :"cat" => true,  :"trout" => false},
			:"Does it prey on other animals?" => { :"mouse" => false, :"cat" => true,  :"trout" => false},
			:"Does it fit in a shoebox?"      => { :"mouse" => true,  :"cat" => false, :"trout" => true },
		}
		qs_filtered = qs_clone(@qs)
		main_loop(qs_filtered)
	end

	def qs_clone(qs) # deep clone
		_clone = Hash.new
		qs.each do |q,animals|
			_animals_clone = Hash.new
			animals.each do |animal,bool|
				_animals_clone[animal] = bool
			end
			_clone[q] = _animals_clone
		end
		return _clone
	end

	def intro_text
		puts "Think of an animal. I will ask questions and try to guess what the animal is."
	end

	def main_loop(qs_filtered) # repl
		vector = Hash.new
		intro_text
		loop do
			q = qs_filtered.keys.sample
			print q
			input = get_input
			bool = input === 'y'
			vector[q] = bool
			qs_filtered = filter(qs_filtered,q,bool)
			puts qs_filtered
			if done(qs_filtered)
				if not guess(qs_filtered)
					learn(vector,qs_filtered)
				end
				exit # to do - keep going 
				start_fresh
			end
		end
	end

	def get_input # from user
		input = ''
		while input != 'y' and input != 'n'
			print " y / n : "
			input = gets.downcase.chomp!
			if input != 'y' and input != 'n'
				puts 'I did not get that, sorry.'
			end
		end 
		return input
	end

	def filter(qs_filtered,q,bool) # reduce remaining questions, animals
		candidates = qs_filtered[q].select {|k,v| v === bool }
		print "candidates: "
		puts candidates
		qs_filtered.each do |q_i,animals_i|
			qs_filtered[q_i] = animals_i.select {|k_i,v_i| candidates.key?(k_i) }
		end
		unless qs_filtered.values[0].count === 1
			qs_filtered.delete(q)
		end
		return qs_filtered
	end

	def done(qs_filtered)
		if qs_filtered.empty? or qs_filtered.values[0].count < 2
			puts "We're done!"
			return true
		end
		return false
	end

	def guess(qs_filtered)
		if bottomed_out?(qs_filtered)
			return false
		end
		print "Is it a "
		puts animal_guess(qs_filtered) + "?"
		input = get_input
		return input === 'y'
	end

	def bottomed_out?(qs_filtered)
		qs_filtered.empty? or qs_filtered.values[0].empty?
	end

	def animal_guess(qs_filtered)
		qs_filtered.values[0].keys[0].to_s
	end

	def learn(vector,qs_filtered)
		print "Gosh. I'm stumped. Please tell me what this creature is: "
		animal_name = gets.downcase.chomp!
		@qs.each do |q,hash|
			if vector.keys.include?(q)
				@qs[q][animal_name.to_sym] = vector[q] # Apply answers to new animal
			else
				print "Regarding a " + animal_name + ": " + q.to_s # Or just ask
				@qs[q][animal_name.to_sym] = get_input === 'y'
			end
		end
		unless bottomed_out?(qs_filtered)
			puts "For next time, please provide a yes or no question that can help me "
			puts "distinguish between a " + animal_guess(qs_filtered) + " and a " + animal_name
			print " : "
			new_q = gets.chomp!
			new_q_row = Hash.new
			@qs.values[0].keys.each do |a_i,bool_i|
				print "Regarding a " + a_i.to_s + ": " + new_q
				new_q_row[a_i] = get_input === 'y'
			end
			@qs[new_q.to_sym] = new_q_row
			puts @qs
		end
	end

	def start_fresh()
		puts "Starting Over ... "
	end
end

Guessing.new