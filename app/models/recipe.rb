class Recipe < ApplicationRecord
  belongs_to :cuisine
  belongs_to :recipe_type
  belongs_to :user

  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients,
            :cook_method, presence: true

  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}
end
