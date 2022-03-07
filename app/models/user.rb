class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of [:first_name, :last_name], on: [:update, :create], message: "can't be blank"

  has_many :business_unit_users       
  has_many :business_units, through: :business_unit_users
 
  has_many :organisation_users       
  has_many :organisations, through: :organisation_users
  

  def name
    ret = "#{first_name} #{last_name}" 
    ret = email if ret.blank?

    ret
  end

  def initials
    "#{first_name.first}#{last_name.first}".upcase
  end

end
