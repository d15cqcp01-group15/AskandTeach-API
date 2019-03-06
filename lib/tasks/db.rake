namespace :db do
  task make_user: :environment do
    100.times do
      User.create! name: Faker::Name.name,
                   username: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: '123456',
                   password_confirmation: '123456'
    end
    puts 'Made users successfully'
  end
end
