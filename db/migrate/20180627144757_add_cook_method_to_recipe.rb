class AddCookMethodToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :cook_method, :string
  end
end
