require 'rubycritic/cli/application'
require 'yaml'

namespace :rubycritic do
  desc 'Run RubyCritic and fail if score is below threshold'
  task check_score: :environment do
    config = YAML.load_file('.rubycritic.yml')
    minimum_score = config['minimum_score']
    options = ['--format', 'lint',
               '--minimum-score', minimum_score.to_s]
    exit_code = RubyCritic::Cli::Application.new(options).execute
    unless exit_code.zero?
      abort('RubyCritic score is below the minimum required.')
    end
  end
end
