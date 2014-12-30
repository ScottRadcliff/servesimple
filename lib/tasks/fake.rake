namespace :fake do
  task :people, [:n] => [:environment] do |t, args|
    (args['n'] || 100).to_i.times do
      Person.create do |p|
        p.name          = "#{Faker::Name.last_name}, #{Faker::Name.first_name}"
        p.phone         = Faker::PhoneNumber.phone_number
        p.email         = Faker::Internet.email
        p.date_of_birth = Faker::Date.backward(rand(13..80) * 365)
      end
    end
  end
end
