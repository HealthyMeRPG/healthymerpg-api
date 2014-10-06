module UniqueToken
  extend ActiveSupport::Concern

  private

  ##
  # Generates a random, unique token for the given field
  def generate_unique_token(column)
    unique_token_generator(column) do
      SecureRandom.urlsafe_base64(64)
    end
  end

  ##
  # Generates a random, unique uuid for the given field
  def generate_uuid(column)
    unique_token_generator(column) do
      SecureRandom.uuid
    end
  end

  ##
  # Helper method, calls the given block and assigns its value to the
  # given column, only if there exists no records that already have
  # the value returned from the block
  def unique_token_generator(column)
    fail 'No block given to unique_token_generator' unless block_given?
    token = loop do
      t = yield
      break t unless self.class.exists?(column => t)
    end
    self[column] = token
  end
end
