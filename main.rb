def handle_input(input)
  result = eval(input)
  puts(" => #{result}")
end

repl = -> prompt do
  qs = {
  	:"Does it have hair?"             => { :"mouse" => true,  :"cat" => true,  :"trout" => false},
  	:"Does it prey on other animals?" => { :"mouse" => false, :"cat" => true,  :"trout" => false},
  	:"Does it fit in a shoebox?"      => { :"mouse" => true,  :"cat" => false, :"trout" => true },
  }
  # puts qs[:"Does it prey on other animals?"][:"mouse"]
  print "are two mice equal? "
  puts qs.values[0].keys[0] === qs.values[1].keys[0]

  print "does a mouse equal a trout? "
  puts qs.values[0].keys[0] === qs.values[1].keys[2]

  print prompt
  handle_input(gets.chomp!)
end

loop do
  repl[">> "]
end
