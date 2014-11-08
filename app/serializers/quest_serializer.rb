class QuestSerializer < ActiveModel::Serializer
  attributes :id, :title, :stamina_reward, :strength_reward, :mind_reward, :vitality_reward, :agility_reward, :activity, :activity_amount
end
