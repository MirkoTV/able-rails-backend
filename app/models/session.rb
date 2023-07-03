class Session < ApplicationRecord
  has_many :performances

  validates :name, uniqueness: true

  def self.current
    Session.where.not(active_at: nil).first || Session.order("created_at DESC").first
  end
end
