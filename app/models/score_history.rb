class ScoreHistory
  include ActiveModel::SerializerSupport

  attr_reader :date, :score

  def initialize(date, score)
    @date = date
    @score = score
  end

  def self.all
    @fixtures ||= YAML.load_file(Rails.root.join('config', 'fixtures', 'score_histories.yml')).deep_symbolize_keys!
    @fixtures[:score_histories].map { |score_history| ScoreHistory.new(score_history[:date], score_history[:score]) }
  end
end
