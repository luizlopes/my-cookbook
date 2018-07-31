class Cuisine < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: { message: 'Você deve informar o nome da cozinha' }
end
