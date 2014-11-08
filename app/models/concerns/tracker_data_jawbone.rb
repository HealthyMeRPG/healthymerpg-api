module TrackerDataJawbone
  private

  def parse_jawbone_steps(response)
    response['body']['data']['items'].reduce(0) do |memo, body_content|
      memo
    end
  end
end
