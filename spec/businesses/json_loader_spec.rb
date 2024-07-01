require_relative '../../app/businesses/data_processing/json_loader'
require 'rails_helper'

RSpec.describe DataProcessing::JsonLoader, type: :model do
  describe '.import_answers' do
    let(:table_name) { 'scores' }
    let(:table_id) { 2 }
    let(:table_field) { 'data' }

    context 'when the record exists' do
      let(:json_data) do
        [
          {
            "lead" => { "name" => "Marco", "email" => "marcodotcastro@gmail.com", "telefone" => "18121212" },
            "answers" => {
              "Você está em transição de carreira?" => "Sim",
              "Você já comprou algum curso de Programação?" => "Sim"
            }
          },
          {
            "lead" => { "name" => "Joao", "email" => "Joao@gmail.com", "telefone" => "111111111" },
            "answers" => {
              "Você está em transição de carreira?" => "Nao",
              "Você já comprou algum curso de Programação?" => "Nao"
            }
          }
        ]
      end

      before do
        allow(ActiveRecord::Base.connection).to receive(:execute)
                                                  .with(ActiveRecord::Base.sanitize_sql(["SELECT * FROM #{table_name} WHERE id = ?", table_id]))
                                                  .and_return([{ 'data' => json_data.to_json }])
      end

      it 'returns the parsed quiz data' do
        result = DataProcessing::JsonLoader.import_answers(table_name, table_field, table_id)
        expect(result).to eq([
                               [
                                 { "name" => "Marco", "email" => "marcodotcastro@gmail.com", "telefone" => "18121212" },
                                 { "Você está em transição de carreira?" => "Sim", "Você já comprou algum curso de Programação?" => "Sim" }
                               ],
                               [
                                 { "name" => "Joao", "email" => "Joao@gmail.com", "telefone" => "111111111" },
                                 { "Você está em transição de carreira?" => "Nao", "Você já comprou algum curso de Programação?" => "Nao" }
                               ]
                             ])
      end
    end

    context 'when the record does not exist' do
      before do
        allow(ActiveRecord::Base.connection).to receive(:execute)
                                                  .with(ActiveRecord::Base.sanitize_sql(["SELECT * FROM #{table_name} WHERE id = ?", table_id]))
                                                  .and_return([])
      end

      it 'returns an empty array' do
        result = DataProcessing::JsonLoader.import_answers(table_name, table_field, table_id)
        expect(result).to eq([])
      end
    end

    context 'when the record is empty' do
      before do
        allow(ActiveRecord::Base.connection).to receive(:execute)
                                                  .with(ActiveRecord::Base.sanitize_sql(["SELECT * FROM #{table_name} WHERE id = ?", table_id]))
                                                  .and_return([{}])
      end

      it 'returns an empty array' do
        result = DataProcessing::JsonLoader.import_answers(table_name, table_field, table_id)
        expect(result).to eq([])
      end
    end
  end
end
