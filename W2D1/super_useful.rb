# PHASE 2
def convert_to_int(str)

  Integer(str)
rescue
  puts "Please, input a digit."
  return nil
end

# PHASE 3
class CoffeeError < StandardError

end

class NonCoffeeError < StandardError

end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit.downcase == "coffee"
    raise CoffeeError
  else
    raise NonCoffeeError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError
    puts "I don't want coffee, I want fruit!!!"
    retry
  rescue NonCoffeeError
    puts "I hate you..."
end
end

# PHASE 4
class ArgumentError < StandardError

end
class BestFriend

  def initialize(name, yrs_known, fav_pastime)

  raise ArgumentError.new ("Years known should be 5 or more.") if yrs_known < 5
  raise ArgumentError.new ("Don't leave me blank") if name.length <= 0
  raise ArgumentError.new ("Enter smth") if fav_pastime.length <= 0

    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
