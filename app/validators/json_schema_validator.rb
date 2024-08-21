class JsonSchemaValidator < ActiveModel::EachValidator
  SCHEMA = {
    'type' => 'object',
    'required' => [
      'Além deste, você já comprou outro curso de Programação?',
      'Qual o seu nome?',
      'Qual seu E-mail?'
    ],
    'properties' => {
      'Além deste, você já comprou outro curso de Programação?' => {
        'type' => 'string',
        'enum' => %w[Sim Não]
      },
      'Qual o seu nome?' => {
        'type' => 'string',
        'minLength' => 5
      },
      'Qual seu E-mail?' => {
        'type' => 'string'
      }
    },
    'additionalProperties' => false
  }.freeze

  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/.freeze

  def validate_each(record, attribute, value)
    JSON::Validator.validate!(SCHEMA, value)

    email = value['Qual seu E-mail?']
    unless email.match?(EMAIL_REGEX)
      record.errors.add(attribute, "contém um e-mail inválido: #{email}")
    end
  rescue JSON::Schema::ValidationError => e
    record.errors.add(attribute, "é inválido: #{e.message}")
  end
end
