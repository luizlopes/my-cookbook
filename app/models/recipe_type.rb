class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false,
                                 message: 'Tipo de receita já existe' },
                   presence: { message: 'Você deve informar o nome do '\
                                        'tipo de receita' }
end
