class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  FULL_WIDTH_KANA_REGEX = /\A[ァ-ヴー]+\z/
  ALPHANUMERIC_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i # rubocop:disable Style/RedundantRegexpCharacterClass

  validates :password, format: { with: ALPHANUMERIC_REGEX, message: 'is invalid. Include both letters and numbers' }

  with_options presence: true do
    validates :nickname, :birthday
    validates :last_name, :first_name, format: { with: FULL_WIDTH_REGEX, message: 'is invalid. Input full-width characters' }
    validates :last_kana, :first_kana,
              format: { with: FULL_WIDTH_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }
  end
end
