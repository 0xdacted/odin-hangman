puts 'Hangman initialized'

possible_words = []
lines = File.readlines('../google-10000-english-no-swears.csv')
lines.each do |line|
  if line.length >= 5 && line.length <= 12
    possible_words.push(line)
  end
end
puts possible_words.length

