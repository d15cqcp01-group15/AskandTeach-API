namespace :db do
  task make_user: :environment do
    30.times do
      User.create! name: Faker::Name.name,
                   username: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: '123456',
                   password_confirmation: '123456'
    end
    puts 'Made users successfully'
  end

  task make_data: :environment do
    @users = User.all

    20.times do
      Course.create! user: @users.sample,
                     price: Faker::Number.decimal(2),
                     time: Time.now,
                     skill: %i[listening speaking reading writing].sample,
                     district: Faker::Address.state,
                     city: Faker::Address.city,
                     address: Faker::Address.full_address,
                     description: Faker::Name.name
    end
  end
end
