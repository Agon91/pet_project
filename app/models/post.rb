class Post < ApplicationRecord
  belongs_to :organization

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }

  #add style to description field
  has_rich_text :description
end
