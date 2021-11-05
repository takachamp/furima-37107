class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname, :birthday, :password_confirmation
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters'} 
    validates :first_name_reading, :last_name_reading, format: {with:/\A[ァ-ヶ一-]+\z/, message: 'is invalid. Input full-width katakana characters'}
  end
  validates :password, :password_confirmation,
  format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze, message: 'is invalid. Include both letters and numbers'}

  has_many :orders
  has_many :items
end
