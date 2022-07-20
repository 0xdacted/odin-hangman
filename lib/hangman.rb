class Player
  @@answer = []
  @@correct_guesses = []
end

class Computer < Player
  def start_game
    possible_words = []
    puts 'Hangman initialized'
    lines = File.readlines('../google-10000-english-no-swears.csv')
    lines.each do |line|
      possible_words.push(line) if line.length >= 5 && line.length <= 13
    end
    string_answer = possible_words.sample.gsub("\n", '')
    string_answer.length.times do
      @@correct_guesses.push('_')
    end
    p @@correct_guesses
    p @@answer = string_answer.split(//)
  end
end

class Human < Player
  def guess
    p "given #{@@correct_guesses}, please input your single character guess and press enter"
    @user_guess = gets.chomp.downcase
    if @user_guess.length == 1
      check_guess
    else
      guess
    end
  end

  def check_guess
    if @@answer.include?(@user_guess)
     index = @@answer.index(@user_guess)
     @@correct_guesses[index] = @user_guess
     p @@correct_guesses
    end
  end
end

computer_player = Computer.new
human_player = Human.new
computer_player.start_game
human_player.guess


