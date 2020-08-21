class Organization < ApplicationRecord
  # Schema relationships
  has_many :admins
  has_many :events
  has_many :favourites
  has_many :posts, dependent: :destroy

  has_many_attached :photos
  has_one_attached :avatar

  belongs_to :category

  # Model validations
  validates :name,          presence: true, length: { minimum: 2 }
  validates :address,       presence: true, length: { minimum: 2 }
  validates :city,          presence: true, length: { minimum: 2 }
  validates :phone_number,  presence: true, length: { minimum: 9 }
  validates :email,         presence: true, length: { minimum: 2 } # Missing the Regex validation
  validates :description,   presence: true, length: { minimum: 5 }

  # Get the Organization's coordinates based on the address and city provided by the user
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?

  # Get the city, zip_code and country based on the coordinates
  reverse_geocoded_by :latitude, :longitude do |organization, results|
    if geo = results.first
      organization.city     = geo.city
      organization.zip_code = geo.postal_code
      organization.country  = geo.country
    end
  end
  after_validation :reverse_geocode

  # Creates a more complete adress from the input provide by the user
  # Only meant to be used in Portugal
  def full_address
    [address, city, "Portugal"].compact.join(', ')
  end

  # Gets the user that is the Organization's admin
  # There's a single admin per Organization
  def find_admin(user)
    current_user_admin = admins.find { |admin| admin.user_id == user.id }
    return current_user_admin
  end
end
