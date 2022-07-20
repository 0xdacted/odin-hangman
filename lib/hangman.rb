class Computer
  def start_game
    possible_words = []
    puts 'Hangman initialized'
    lines = File.readlines('../google-10000-english-no-swears.csv')
    lines.each do |line|
      possible_words.push(line) if line.length >= 5 && line.length <= 12
    end
    answer = possible_words.sample
    answer.length.times do
      puts '_'
    end
  end
end

computer_player = Computer.new
computer_player.start_game
