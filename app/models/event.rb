class Event < ApplicationRecord
  has_many :event_users
  has_many :users, throught: :event_users
end
