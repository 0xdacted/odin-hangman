require 'yaml'

class Game
  attr_accessor :answer, :correct_guesses, :tries, :string_answer
  def initialize 
  @answer = []
  @correct_guesses = []
  @tries = 15
  @string_answer = ''
  end

  def save_game
    File.open('saved_game.yml', 'w') { |f| YAML.dump([] << self, f) }
    puts 'Game Saved!'
  end

  def load_game
    yaml = YAML.load_file('./saved_game.yml', permitted_classes: [Game])
    @answer = yaml[0].answer
    @correct_guesses = yaml[0].correct_guesses
    @tries = yaml[0].tries
    @string_answer = yaml[0].string_answer
    puts 'Save Loaded!'
  end

  def guess
    p "given #{@correct_guesses}, please input your single character guess and press enter, if you would like to save, input 'yes'"
    @user_guess = gets.chomp.downcase
    if @user_guess.length == 1
      check_guess
    elsif @user_guess == 'yes'
      save_game
      exit
    else
      guess
    end
  end

  def check_guess
    if @answer.include?(@user_guess)
      @answer.each_with_index do |element, index|
        if element == @user_guess
          @correct_guesses[index] = @user_guess
          p @correct_guesses
        else
          next
        end
      end
      @tries -= 1
      p "Congratulations! #{@user_guess} is included in the given word. You have #{@tries} tries left"
    else
      @tries -= 1
      p "Sorry! #{@user_guess} is not included in the given word. You have #{@tries} tries left"
    end
  end

  def game_loop
    puts "if you would like to load a previous game, input 'yes', else input 'no' to start a new game"
    load_or_new = gets.chomp.downcase
    if load_or_new == 'yes'
      load_game
    elsif load_or_new == 'no'
    else
      game_loop
    end

    loop do
      if @tries == 0
        p "You have #{@tries} guesses left, you have lost. Please restart the game if you would like to try again!"
        break
      end
        guess
  
      if @correct_guesses == @answer
        p "Great job! You have successfully guessed the entire word: #{@string_answer}. You win!"
        break
      end
    end
  end

  def start_game
    possible_words = []
    puts 'Hangman initialized'
    lines = File.readlines('../google-10000-english-no-swears.csv')
    lines.each do |line|
      possible_words.push(line) if line.length >= 5 && line.length <= 13
    end
    @string_answer = possible_words.sample.gsub("\n", '')
    @string_answer.length.times do
      @correct_guesses.push('_')
    end
    @answer = @string_answer.split(//)
    game_loop
  end
end

new_game = Game.new
new_game.start_game
