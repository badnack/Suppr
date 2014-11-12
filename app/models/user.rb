class User < ActiveRecord::Base
  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  has_many :reservations
  has_many :dinners, :through => :reservations

  devise :omniauthable, :database_authenticatable, :registerable,
  # :confirmable, #Add this for email confirmation
  :recoverable, :rememberable, :trackable, :validatable
end

def only_if_unconfirmed
  pending_any_confirmation {yield}
end
