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

  # Create Weight
  Weight.create(
    description: FFaker::Conference.name,
    status: [:active, :inactive].sample,
    question_answer: { 'Além deste, você já comprou outro curso de Programação?' => { 'Sim' => 10, 'Não' => 5 } }
  )

  # Create SurveyParticipation
  SurveyParticipation.create(
    question_answer_pair:       {
      'Além deste, você já comprou outro curso de Programação?' => 'Sim',
      'Qual o seu nome?' => 'Thales Henrique Cardoso',
      'Qual seu E-mail?' => 'thales.milion25@gmail.com'
    }
  )

  Score.create!(name: 'João', value: 100)
  Score.create!(name: 'Alice', value: 80)
  Score.create!(name: 'Maria', value: 95)
end
