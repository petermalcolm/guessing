
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
		puts @qs
		puts '- - -'
		puts qs_filtered
		puts '- - -'
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

	def main_loop(qs_filtered) # repl
		loop do
			q = qs_filtered.keys.sample
			print q
			input = get_input
		end
	end

	def get_input
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
end

Guessing.new