class Game
  @@answer = []
  @@correct_guesses = []
  @@tries = 15
  @@string_answer = ''
end

class Computer < Game
  def start_game
    possible_words = []
    puts 'Hangman initialized'
    lines = File.readlines('../google-10000-english-no-swears.csv')
    lines.each do |line|
      possible_words.push(line) if line.length >= 5 && line.length <= 13
    end
    @@string_answer = possible_words.sample.gsub("\n", '')
    @@string_answer.length.times do
      @@correct_guesses.push('_')
    end
    @@answer = @@string_answer.split(//)
  end
end

class Human < Game
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
      @@answer.each_with_index do |element, index|
        if element == @user_guess
          @@correct_guesses[index] = @user_guess
          p @@correct_guesses
        else
          next
        end
      end
      @@tries -= 1
      p "Congratulations! #{@user_guess} is included in the given word. You have #{@@tries} tries left"
    else
      @@tries -= 1
      p "Sorry! #{@user_guess} is not included in the given word. You have #{@@tries} tries left"
    end
  end

  def start_game
    until @@tries == -1
      if @@tries == 0
        p "You have #{@@tries} guesses left, you have lost. Please restart the game if you would like to try again!"
        break
      end
      guess
      if @@correct_guesses == @@answer
        p "Great job! You have successfully guessed the entire word: #{@@string_answer}. You win!"
        break
      end
    end
  end
end

computer_player = Computer.new
human_player = Human.new
computer_player.start_game
human_player.start_game
