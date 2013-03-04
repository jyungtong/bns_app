class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

	has_one :profile, dependent: :destroy
	has_one :education_profile, dependent: :destroy
	has_many :user_events
	has_many :events, through: :user_events

	def full_name
		"#{first_name} #{last_name}"
	end
end
