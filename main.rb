
repl = -> prompt do
  # puts qs[:"Does it prey on other animals?"][:"mouse"]
  print "are two mice equal? "
  puts qs.values[0].keys[0] === qs.values[1].keys[0]

  print "does a mouse equal a trout? "
  puts qs.values[0].keys[0] === qs.values[1].keys[2]
end


class Guessing
	def initialize()
		qs = {
			:"Does it have hair?"             => { :"mouse" => true,  :"cat" => true,  :"trout" => false},
			:"Does it prey on other animals?" => { :"mouse" => false, :"cat" => true,  :"trout" => false},
			:"Does it fit in a shoebox?"      => { :"mouse" => true,  :"cat" => false, :"trout" => true },
		}
		main_loop()
	end

	def main_loop()
		loop do
			print " >>"
			handle_input(gets.chomp!)
		end
	end

	def handle_input(input)
		result = eval(input)
		puts(" => #{result}")
	end
end

Guessing.new