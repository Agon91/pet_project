class Organization < ApplicationRecord
  geocoded_by :address
  geocoded_by :full_address
  after_validation :geocode
  has_many :admins

  has_many :favourites
  has_many :events, dependent: :destroy

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

  def find_admin(user)
    current_user_admin = admins.find{|admin|
      admin.user_id == user.id
    }
    return current_user_admin
  end

  def full_address
    [:address, :city, :zip_code, :country].compact.join(', ')
  end
end
