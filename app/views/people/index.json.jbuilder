json.array!(@people) do |person|
  json.extract! person, :id, :name, :gender, :phone, :email, :date_of_birth
  json.url person_url(person, format: :json)
end
