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

  task update_location_course_event: :environment do
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

    Event.all.each do |event|
      event.district = districts.sample
      event.city = citites
      event.save

    end

    puts 'Update location successfully !'
  end

  task update_user_infor: :environment do

    users = User.all
    users.each do |user|
      user.self_introduce = Faker::Lorem.paragraph(10)
      user.birthday = Faker::Date.between(2.days.ago, Date.today)
      user.save
    end

    puts '-------->Update users infor Succesfully'

  end

  task handle_time_for_course_and_event: :environment do
    Course.all.each do |course|
      course.open_time = (1570286196..1628174196).to_a.sample
      course.save
    end
    Event.all.each do |event|
      event.open_time = (1570286196..1628174196).to_a.sample
      event.save
    end
  end

  task update_phone_number_for_user: :environment do
    User.all.each do |user|
      user.phone_number = Faker::PhoneNumber.phone_number
      user.save
    end
  end

  task update_user_profile_image: :environment do

    PT1 = 'https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg'
    PT2 = 'https://amp.businessinsider.com/images/5899ffcf6e09a897008b5c04-750-750.jpg'
    PT3 = 'http://www.anaivanovic.com/sites/default/files/styles/flexslider_full_mobile/public/profile.jpg?itok=50Q_EqHf'
    PT4 = 'https://img2.thejournal.ie/inline/2470754/original/?width=428&version=2470754'
    PT5 = 'https://www.eharmony.co.uk/dating-advice/wp-content/uploads/2018/06/datingprofile2-900x600.jpg'

    User.all.each do |user|
      user.profile_image = [PT1, PT2, PT3, PT4, PT5].sample
      user.save
    end

  end

  task update_course_description: :environment do
    CNT1 = 'Lớp tại TNT ENglish: mỗi lớp học không quá 15 Học viên, cùng một trình độ.
     Vui lòng làm bài kiểm tra trình độ tiếng anh miễn phí để được xếp lớp phù hợp.
     Sau khi kiểm tra, TNT ENglish sẽ thông báo lại cho bạn biết trình độ tiếng anh của bạn,
     và lịch khai giảng lớp học phù hợp với trình độ của bạn để bạn thu xếp lịch phù hợp và đăng kí học.'
    CNT2 = 'Đào tạo doanh nghiệp: TNT ENglish sẽ trao đổi với Doanh nghiệp để tìm hiểu nhu cầu học tiếng anh của cán bộ nhân viên và đưa ra một chương trình học phù hợp,
     sau đó cử giáo viên đến tận nơi đề đào tạo cho cán bộ nhân viên của Doanh nghiệp.
     Vui lòng xem chi tiết ở hình thức đào tạo tiếng anh doanh nghiệp.'
    CNT3 = 'Học riêng theo yêu cầu: Học viên muốn học lớp riêng tại nhà hoặc văn phòng theo chương trình riêng đáp ứng công việc của mình có thể đăng ký lớp học tiếng anh giao tiếp theo yêu cầu.
     Lớp học phù hợp với những người bận rộn, muốn học tiếng anh cấp tốc,
     hoặc học theo chương trình riêng, đặc thù.'
     Course.all.each do |course|
       course.description = [CNT1, CNT2, CNT3].sample
       course.save
     end
  end
end
