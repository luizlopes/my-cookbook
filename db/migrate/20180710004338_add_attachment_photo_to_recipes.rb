class AddAttachmentPhotoToRecipes < ActiveRecord::Migration[5.1]
  def change
    #add_column :recipes, :photo, :attachment
    add_attachment :recipes, :photo
  end
end
