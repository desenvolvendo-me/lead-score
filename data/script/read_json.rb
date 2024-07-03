require 'json'

# Caminho para o arquivo JSON
file_path = 'data/table_customers.json'

# Ler o arquivo JSON
file = File.read(file_path)
data = JSON.parse(file)

# Inicializar hashes para armazenar perguntas e respostas
questions_answers_list = []


# Processar os dados
data.each do |entry|
  questions = entry["questions"]
  questions.each do |question, answer|
    questions_answers_list << question
    questions_answers_list << answer
  end
end

# Exibir as perguntas e respostas
puts "Perguntas:"
questions_answers_list.each do |question, answer|
  puts question
  puts answer

end

puts "-" * 20

