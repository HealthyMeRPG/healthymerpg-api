class Quest < ActiveRecord::Base
  enum activity: [ :steps ]
end
