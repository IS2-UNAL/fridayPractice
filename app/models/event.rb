class Event < ApplicationRecord
  default_scope {order("events.name ASC")}
  scope :order_by_name, -> (type) {order("events.name #{type}")}
  has_many :event_users
  has_many :users, through: :event_users

  def self.load_events(page = 1, per_page = 10)
    includes(users: [:posts,:products,:comments,:favorte_products])
      .paginate(:page => page,:per_page => :per_page)
  end

  def self.event_by_id(id)
    includes(users: [:posts,:products,:comments,:favorte_products])
      .find_by_id(id)
  end

  def self.events_by_ids(ids,page = 1, per_page = 10)
    load_events(page,per_page)
      .where(events:{
        id: ids
      })
  end

  def self.events_by_not_ids(ids,page = 1, per_page = 10)
    load_events(page,per_page)
      .where.not(events:{
        id: ids
      })
  end

end
