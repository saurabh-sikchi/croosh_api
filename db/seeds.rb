# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

videos = [
  "model-1.mp4",
  "model-2.mp4",
  "model-3.mp4",
  "model-4.mp4",
  "model-11.mp4",
]

Croosh.destroy_all
User.destroy_all
Celeb.destroy_all

['Rishab J', 'Mankani', 'Sikchi'].each { |name| User.create!(name: name) }

celebs_data = [
  {
    name: "Priyank Chopra",
    image: "celebs_seed/celeb-1.jpg",
    rate_per_croosh: "15000",
    ready_to_go_live: true,
    nick: "piggy.chops",
    video: "celebs_seed/model-1.mp4"
  },
  {
    name: "Nora Fateghi",
    image: "celebs_seed/celeb-2.jpg",
    rate_per_croosh: "1500",
    ready_to_go_live: true,
    nick: "nora.fatehi",
    video: "celebs_seed/model-2.mp4"
  },
  {
    name: "Pearl Sharma",
    image: "celebs_seed/celeb-3.jpg",
    rate_per_croosh: "5000",
    ready_to_go_live: true,
    nick: "iampearl",
    video: "celebs_seed/model-3.mp4"
  },
  {
    name: "Kid Ink",
    image: "celebs_seed/celeb-4.jpg",
    rate_per_croosh: "15000",
    ready_to_go_live: true,
    nick: "inky.hashes",
    video: "celebs_seed/model-4.mp4"
  },
  {
    name: "Badshah",
    image: "celebs_seed/celeb-5.jpg",
    rate_per_croosh: " 3000",
    ready_to_go_live: true,
    nick: "jumpingkiddo"
  },
  {
    name: "Yami Gautam",
    image: "celebs_seed/celeb-6.jpg",
    rate_per_croosh: "15000",
    ready_to_go_live: true,
    nick: "yami.gautam"
  },
  {
    name: "Nayak Chopra",
    image: "celebs_seed/celeb-7.jpg",
    rate_per_croosh: "15000",
    ready_to_go_live: true,
    nick: "nyka.c"
  },
  {
    name: "Katrina kaif",
    image: "celebs_seed/celeb-8.jpg",
    rate_per_croosh: "1500",
    ready_to_go_live: true,
    nick: "kat.kaif"
  },
  {
    name: "Disha Patani",
    image: "celebs_seed/celeb-9.jpg",
    rate_per_croosh: " 1000",
    ready_to_go_live: true,
    nick: "love.dogs"
  },
  {
    name: "Anushka Shetty",
    image: "celebs_seed/celeb-10.jpg",
    rate_per_croosh: "2500",
    ready_to_go_live: true,
    nick: "anushka.shetty"
  },
  {
    name: "Alia Bhatt",
    image: "celebs_seed/celeb-11.jpg",
    rate_per_croosh: "5000",
    ready_to_go_live: true,
    nick: "bhatt.alia",
    video: "celebs_seed/model-11.mp4"
  },
  {
    name: "Sonal Chauhan",
    image: "celebs_seed/celeb-12.jpg",
    rate_per_croosh: "2000",
    ready_to_go_live: true,
    nick: "rajput.sonal"
  },
  {
    name: "Shirley Setia",
    image: "celebs_seed/celeb-13.jpg",
    rate_per_croosh: "9500",
    ready_to_go_live: true,
    nick: "setia.cute"
  },
  {
    name: "Dharshan Raval",
    image: "celebs_seed/celeb-14.jpg",
    rate_per_croosh: "4000",
    ready_to_go_live: true,
    nick: "dharshan.raval"
  },
  {
    name: "Kiara Advani",
    image: "celebs_seed/celeb-15.jpg",
    rate_per_croosh: "3000",
    ready_to_go_live: true,
    nick: "kiara.advani"
  },
  {
    name: "Priyank Chopra",
    image: "celebs_seed/celeb-16.jpg",
    rate_per_croosh: "15000",
    ready_to_go_live: true,
    nick: "piggy.chops"
  },
  {
    name: "Virat Kohli",
    image: "celebs_seed/celeb-17.jpg",
    rate_per_croosh: "150000",
    ready_to_go_live: true,
    nick: "viral.kohli"
  },
  {
    name: "Manish Pandey",
    image: "celebs_seed/celeb-18.jpg",
    rate_per_croosh: "25000",
    ready_to_go_live: true,
    nick: "manish.pandey"
  },
  {
    name: "Hardik Pandya",
    image: "celebs_seed/celeb-19.jpg",
    rate_per_croosh: "75000",
    ready_to_go_live: true,
    nick: "karke.aaya"
  }
]

known_fors = [
  'Amazing TV star',
  "World's greatest wrestler",
  "Being a friend of Sikchi",
  "Not known for jack",
  "Attempting to overthrow the burgeois",
  "Watching Rick and Morty 17 times",
  "Being a generally nice person"
]

celebs_data.each do |celeb_data|
  path_to_image = Rails.root.join('app/assets').join(celeb_data[:image])
  image_filename = File.basename(path_to_image)

  
  celeb = Celeb.new(celeb_data.except(:image, :video))

  celeb.known_for = known_fors[rand(0...known_fors.length)]
  celeb.save!
  
  celeb.pics.attach(io: File.open(path_to_image), filename: image_filename)

  if celeb_data[:video]
    path_to_video = Rails.root.join('app/assets').join(celeb_data[:video])
    video_filename = File.basename(path_to_video)
    celeb.profile_video.attach(io: File.open(path_to_video), filename: video_filename)
  end

end

user = User.first

if user
  croosh_data = [
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    },
    {
      created_at: "Jun 22, 2020",
    }
  ];

  croosh_data.each do |c|
    celeb = Celeb.order('RAND()').limit(1).take
    croosh = Croosh.new(c.except(:image))
    croosh.celeb = celeb
    croosh.user = User.last
    croosh.user_likes_count = 0 if croosh.user_likes_count.nil?
    v = videos[rand(0...videos.length)]

    path_to_video = Rails.root.join('app/assets/celebs_seed').join(v)
    video_filename = File.basename(path_to_video)
    croosh.save!
    croosh.video.attach(io: File.open(path_to_video), filename: video_filename)

  end
end