class AddCookTimeToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :cook_time, :integer
  end
end
