class Category < ApplicationRecord
  has_many :organizations

  validates :name, presence: :true, uniqueness: true
  validates :icon, presence: :true, uniqueness: true
end
