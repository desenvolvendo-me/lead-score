require 'json'

# Caminho para o arquivo JSON
file_path = 'data/tabela_peso.json'

# Ler o arquivo JSON
file = File.read(file_path)
data = JSON.parse(file)

# Verificar se o JSON está formatado corretamente
unless data.is_a?(Hash)
  puts "Erro: O JSON não está formatado como um hash."
  exit
end

# Exibir as perguntas e respostas
data.each do |question, answers|
  unless answers.is_a?(Hash)
    puts "Erro: Respostas para a pergunta '#{question}' não estão formatadas corretamente."
    next
  end

  puts "Pergunta: #{question}"
  answers.each do |answer, weight|
    puts "  Resposta: #{answer} - Peso: #{weight}"
  end
end

puts "Validação completa."
