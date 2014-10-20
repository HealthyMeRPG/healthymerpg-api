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
end
