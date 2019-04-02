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
  task make_topic: :environment do
    @users = User.all
    30.times do
      Topic.create! creator: @users.sample,
                    title: Faker::Name.name,
                    content: Faker::Lorem.paragraph,
                    topic_type: %i[speaking reading listening writing].sample
    end
  end
  task update_cover_course: :environment do
    LIST_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554216712/listen.jpg'
    READ_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172721/reading.jpg'
    WRITE_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172781/writing.jpg'
    SPEAK_URL = 'https://res.cloudinary.com/no-nam/image/upload/v1554172881/speaking.jpg'

    Course.all.each do |course|
      if course.speaking?
        course.cover_image = SPEAK_URL
        course.save
      end
      if course.reading?
        course.cover_image = READ_URL
        course.save
      end
      if course.writing?
        course.cover_image = WRITE_URL
        course.save
      end
      if course.listening?
        course.cover_image = LIST_URL
        course.save
      end
    end
    puts 'update cover image for course successfully'
  end

  task update_location_course: :environment do
    districts = ['Quận 1', 'Quận 2', 'Quận 3',
                 'Quận 5', 'Quận 6', 'Quận 4',
                 'Quận 7', "Quận 8", 'Quận 9',
                 'Quận 10', 'Quận 11', 'Quận 12',
                 'Quận Thủ Đức', 'Quận Gò Vấp',
                 'Quận Bình Thạnh', 'Quận Tân Bình',
                 'Quận Tân Phú', 'Quận Phú Nhuận',
                 'Quận Bình Tân', 'Quận Củ Chi'
               ]
    citites = 'TP Hồ Chí Minh'

    Course.all.each do |course|
      course.district = districts.sample
      course.city = citites
      course.save
    end

    puts 'Update location successfully !'
  end
end
