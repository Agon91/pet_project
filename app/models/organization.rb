class Organization < ApplicationRecord
  has_many :admin
  has_many :posts, dependent: :destroy
  has_many_attached :photos

  validates :name,          presence: true, length: { minimum: 2 }
  validates :address,       presence: true, length: { minimum: 2 }
  validates :phone_number,  presence: true, length: { minimum: 2 }
  validates :email,         presence: true, length: { minimum: 2 }
  validates :category,      presence: true, length: { minimum: 2 }
  validates :description,   presence: true, length: { minimum: 2 }
  validates :city,          presence: true, length: { minimum: 2 }
  validates :zip_code,      presence: true, length: { minimum: 2 }
  validates :country,       presence: true, length: { minimum: 2 }
end
