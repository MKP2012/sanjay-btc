class User < ApplicationRecord
	validates :username, presence: true
	validates :wallet, :numericality => { :greater_than_or_equal_to => 0 }
	has_many :transactions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
