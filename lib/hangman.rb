class Computer
  puts 'Hangman initialized'
  @@possible_words = []
  def start_game
    lines = File.readlines('../google-10000-english-no-swears.csv')
    lines.each do |line|
      if line.length >= 5 && line.length <= 12
      @@possible_words.push(line)
    end
  end
  answer = @@possible_words.sample
  answer.length.times do
    puts '_'
    end
  end
end

computer_player = Computer.new
computer_player.start_game
