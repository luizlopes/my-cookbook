class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy

  mensagem = 'Você deve informar o nome do tipo de receita'
  validates :name, presence: { message: mensagem }
end
