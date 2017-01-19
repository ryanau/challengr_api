class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :challenges

  def self.from_omniauth(user_info, access_token)
    where(uid: user_info['id']).first_or_create! do |user|
      user.email = user_info['email'] || 'default@example.com'
      user.password = Devise.friendly_token(15)
      user.access_token = user_info['access_token']
      user.first_name = user_info['first_name']
      user.last_name = user_info['last_name']
    end
  end
end
