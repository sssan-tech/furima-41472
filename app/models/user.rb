class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  FULL_WIDTH_KANA_REGEX = /\A[ァ-ヶー]+\z/
  ALPHANUMERIC_REGEX = /(?=.*[a-z])(?=.*[\d])\A[a-z\d]+\z/i

  validates :password, format: {with: ALPHANUMERIC_REGEX, message: "is invalid. Include both letters and numbers"}
  
  with_options presence: true do
    validates :nickname, :birthday
    validates :last_name, :first_name, format: {with: FULL_WIDTH_REGEX, message: "is invalid. Input full-width characters"}
    validates :last_kana, :first_kana, format: {with: FULL_WIDTH_KANA_REGEX, message: "is invalid. Input full-width katakana characters"}
  end
end
