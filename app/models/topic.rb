class Topic < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id

  enum topic_type: %i[listening speaking reading writing]

  TOPIC_DATA = [:id, :title, :content, :topic_type, :created_at]
end
