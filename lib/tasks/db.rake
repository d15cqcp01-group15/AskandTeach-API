namespace :db do
  task make_user: :environment do

    # User for checking
    User.create! name: Faker::Name.name,
                 username: Faker::Name.name,
                 email: 'thiennguyen.mark@gmail.com',
                 password: '123456',
                 password_confirmation: '123456'

    # Making user
    30.times do
      User.create! name: Faker::Name.name,
                   username: Faker::Name.name,
                   email: Faker::Internet.email,
                   password: '123456',
                   password_confirmation: '123456'
    end
    puts '-----------> Made users successfully'
  end

  task make_data: :environment do
    @users = User.all

    # Making courses
    20.times do
      Course.create! user: @users.sample,
                     price: Faker::Number.decimal(2),
                     uptime: Time.now,
                     skill: %i[listening speaking reading writing].sample,
                     district: Faker::Address.state,
                     city: Faker::Address.city,
                     address: Faker::Address.full_address,
                     description: Faker::Name.name
    end
    puts '-----------> Made Courses successfully'

    @courses = Course.all

    # Making details courses
    100.times do
      DetailCourse.create! user: @users.sample,
                           course: @courses.sample
    end
    puts '-----------> Made Detail Course successfully'

    # Making event courses
    30.times do
      Event.create! user: @users.sample,
                    title: Faker::Name.name,
                    district: Faker::Address.state,
                    city: Faker::Address.city,
                    address: Faker::Address.full_address,
                    uptime: Time.now,
                    price: Faker::Number.decimal(2),
                    description: Faker::Name.name
    end
    puts '-----------> Made Events Course successfully'

    @events = Event.all

    # Making Details Event courses
    100.times do
      DetailEvent.create! user: @users.sample,
                          event: @events.sample
    end
    puts '-----------> Made Details Events Course successfully'
  end
end
