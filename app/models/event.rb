class Event < ApplicationRecord
  belongs_to :organization
  has_many :participations

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :part_count, presence: true

  #add style to description field
  has_rich_text :description
end
