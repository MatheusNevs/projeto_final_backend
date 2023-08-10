class User < ApplicationRecord
  acts_as_token_authenticatable
  
  validates :name, presence: :true
  validates :last_name, presence: :true
  validates :email, presence: :true, uniqueness: :true
  validates :is_admin, inclusion: [true, false], exclusion: [nil]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture
end
