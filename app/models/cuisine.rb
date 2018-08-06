class Cuisine < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false,
                                 message: 'Cozinha já existe' },
                   presence: { message: 'Você deve informar o nome da cozinha' }
end
