if Rails.env.development?
  AdminUser.create!(email: 'admin@mail.com',
                    password: '000000', password_confirmation: '000000')
  user_1 = User.create!(name: 'User 1', email: 'user1@mail.com',
                        password: '000000', password_confirmation: '000000',confirmed_at: Time.now )
  user_2 = User.create!(name: 'User 2', email: 'user2@mail.com',
                        password: '000000', password_confirmation: '000000',confirmed_at: Time.now )

  client_1 = Client.create(document: '81939120047', user: user_1)
  client_2 = Client.create(document: '66778473061', user: user_2)

  user_1.client = client_1
  user_1.save
  user_2.client = client_2
  user_2.save

  user_1.avatar.attach(io: File.open(
    Rails.root.join('spec', 'support', 'images', 'avatar-1.jpg')),
                       filename: 'avatar-1', content_type: 'image/jpg')

  # Create ApiToken
  token = SecureRandom.hex(20)
  ApiToken.create(token: token, client: user_1.client, user: user_1)

  # Add api_token to user_1
  user_1.update(api_token: token)

  Goal.create(name: 'Aprender Linguagem Ruby',
                      description: 'Quero criar 10 algoritmos em até 3 meses', status: 'done', client: client_1)

  Goal.create(name: 'Aprender Framework Rails',
                      description: 'Quero criar 5 projetos simples em até 3 meses', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Linguagem Python',
                      description: 'Quero criar 5 scripts úteis em até 2 meses', status: 'doing', client: client_1)

  Goal.create(name: 'Aprender Banco de Dados SQL',
                      description: 'Quero criar um banco de dados de livros em até 1 mês', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Front-End Development',
                      description: 'Quero construir um portfólio online em 2 semanas', status: 'done', client: client_1)

  Goal.create(name: 'Aprender Linguagem JavaScript',
                      description: 'Quero dominar os conceitos básicos em 1 mês', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Desenvolvimento Mobile',
                      description: 'Quero criar um aplicativo simples em 2 meses', status: 'doing', client: client_1)

  Goal.create(name: 'Aprender Testes de Software',
                      description: 'Quero escrever testes para um projeto em 1 mês', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Cloud Computing',
                      description: 'Quero implantar um aplicativo em nuvem em 2 semanas', status: 'doing', client: client_1)

  Goal.create(name: 'Aprender Design de Interface',
                       description: 'Quero criar um design para um site em 1 mês', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Machine Learning',
                       description: 'Quero criar um modelo de machine learning em 2 meses', status: 'done', client: client_1)

  Goal.create(name: 'Aprender Redes de Computadores',
                       description: 'Quero configurar uma rede local em 3 semanas', status: 'todo', client: client_1)

  Goal.create(name: 'Aprender Segurança da Informação',
                       description: 'Quero realizar um teste de penetração em 1 mês', status: 'doing', client: client_1)

  Goal.create(name: 'Aprender Desenvolvimento Web Full-Stack',
                       description: 'Quero criar um aplicativo completo em 2 meses', status: 'doing', client: client_1)

  Goal.create(name: 'Aprender Inteligência Artificial',
                       description: 'Quero criar um chatbot em 1 mês', status: 'done', client: client_2)


  Score.create!(name: 'João', value: 100)
  Score.create!(name: 'Alice', value: 80)
  Score.create!(name: 'Maria', value: 95)

end
