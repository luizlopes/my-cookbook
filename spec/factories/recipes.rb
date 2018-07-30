FactoryBot.define do
  factory :recipe do
    title 'Macarrão'
    difficulty 'Fácil'
    cook_time 50
    ingredients 'Macarrão, oleo e sal'
    cook_method 'Ferva água com oleo e jogue o macarrão dentro'
    photo File.new(Rails.root.join('spec', 'support', 'macarrao.jpg'))
  end
end
