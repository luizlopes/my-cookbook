class AddCuisineToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :cuisine, :string
  end
end
