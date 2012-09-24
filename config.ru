require "./application"

# Print the stack for fun!
puts ">> Starting Rails stack"
Rails.configuration.middleware.each do |middleware|
  puts "use #{middleware.inspect}"
end
puts "run #{Rails.application.class.name}.routes"

run DuNordMap