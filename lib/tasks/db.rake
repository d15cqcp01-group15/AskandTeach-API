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
    nums = ['0387225832', '0372045786', '0392742735']
    User.all.each do |user|
      user.phone_number = nums.sample
      user.save
    end
  end

  task update_user_profile_image: :environment do

    PT1 = 'https://res.cloudinary.com/no-nam/image/upload/v1558709957/anhcanhan.jpg'
    PT2 = 'https://res.cloudinary.com/no-nam/image/upload/v1558710012/tai1.jpg'
    PT3 = 'https://res.cloudinary.com/no-nam/image/upload/v1558710002/duc1.jpg'

    User.all.each do |user|
      user.profile_image = [PT1, PT2, PT3].sample
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

  task update_user_name: :environment do
    name1 = 'Thiện Nguyễn'
    name2 = 'Đức Tài'
    name3 = 'Anh Đức'

    User.all.each do |user|
      user.username = [name1, name2, name3].sample
      user.save
    end

    Course.where(user_id: 35).each do |course|
      course.address = Faker::Address.full_address
      course.save
    end
  end

  task make_deadline: :environment do
    Course.all.map do |course|
      time = Time.zone.now + 172800
      course.deadline_of_registration = time.to_f
      course.save
    end
  end

  task handle_title_event: :environment do
    titles = [
      "Phát âm cuối sao cho đúng",
      "Làm sao cải thiện cho người mới bắt đầu",
      "Học tiếng Anh sao cho hiệu quả",
      "Phương pháp học tiếng Anh của người nổi tiếng",
      "Giao lưu cùng Khánh Vy"
    ].freeze

    descriptions = [
      "Londoner là một trong những trang blog nổi tiếng nhất ở Anh. Tại đây, tác giả Rosie chia sẻ về tất cả các khía cạnh của cuộc sống hằng ngày, từ công thức nấu ăn, phong cách ăn mặc hay cả về chú chó xinh xắn của cô ấy khi họ ở London. Với nội dung khá thu hút cùng với khả năng miêu tả sinh động và chi tiết, trang này khá phù hợp với người nói tiếng Anh ở trình độ sơ cấp",
      "Đừng nói với tôi là bạn chưa từng nghe đến trang Deliciously Ella nhé?! Blog của Ella là nơi cô chia sẻ những ý tưởng nấu nướng độc đáo và những lần trải nghiệm làm bánh với rau củ và các loại nguyện liệu hoàn toàn tự nhiên. Và các bài viết của cô cũng đã tạo cảm hứng cho hàng triệu người trong việc duy trì một lối sống lành mạnh.",
      "Những phát thanh viên của đài BBC từ trước đến này luôn được biết đến với chất giọng Anh Anh siêu chuẩn của mình hay những bài báo của họ luôn được viết bằng một văn phong lôi cuốn và cấu trúc ngữ pháp đa dạng. Cho nên đây là nơi lý tưởng đề học tiếng Anh. Trang này cung cấp hàng trăm video, bài viết và bài tập miễn phí cho tất cả đối tượng học viên.",
      "Bạn sẽ lập tức đi lấy ngay hộ chiếu và dọn đồ cho chuyến đi của mình trước khi có thể thốt lên bạn yêu thích trang blog này và những bức hình tuyệt đẹp được đăng tải ở đây nhiều thế nào. Bạn có thể tìm thấy mọi thứ từ những nơi có ẩm thực tuyệt vời nhất đến những địa điểm ít người đặt chân đến, World of Wanderlust cung cấp cho bạn những kinh nghiệm quý giá để lên kế hoạch cho chuyến đi của mình.",
      "Trang blog đặt theo tên với tác giả này mang đến những bài viết về Tiếng Anh thông dụng của người Anh trong đời sống hằng ngày. Trước đây cô từng là nhà báo và những bài viết của cô thường xoay quanh những mối quan hệ trong cuộc sống, những quyển sách yêu thích và cả phong cách ăn mặc. Khi đọc blog của Hannah, bạn sẽ học được những cụm từ hay ho và cả những từ long mà thầy cô không dạy bạn trên lớp."
    ]

    Event.all.each do |event|
      event.title = titles.sample
      event.description = descriptions.sample
      event.save
    end
  end
end
