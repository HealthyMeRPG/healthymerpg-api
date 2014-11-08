module TrackerDataFitbit
  private

  def parse_fitbit_steps(response)
    response['body'].reduce(0) do |memo, body_content|
      total_steps = body_content['result']['content']['activities-steps'].reduce(0) do |memo, steps|
        memo + steps['value'].to_i
      end

      memo + total_steps
    end
  end

  def parse_fitbit_activity(response)
    memo = {
      calories_burned: 0,
      floors: 0,
      very_active_minutes: 0
    }
    response['body'].reduce(memo) do |memo, body_content|
      summary = body_content['result']['content']['summary']

      {
        calories_burned: memo[:calories_burned] + summary['caloriesOut'],
        floors: memo[:floors] + summary['floors'],
        very_active_minutes: memo[:very_active_minutes] + summary['veryActiveMinutes']
      }
    end
  end
end
