# All celebs in celeb_seeds = 10-11
# All crooshes in croosh_seeds = 40-50

Croosh.destroy_all
Celeb.destroy_all
User.destroy_all

# user
u = User.create!(name: 'Saurabh')
OtpAuthentication.create!(phone_number: '8446251980', otp: '555', succeeded: true, user: u)

# celebs
cute_names = ["Alvin","Asia","Audi","Bagel","Balou","Barclay","Barney","Beck","Bellatrix","Bianca","Biloxi","Birdie","Biscuit","Blanca","Bobbafett","Bodie","Bono","Booboo","Bootsie","Bordeaux","Brandy","Bren","Bronco","Bruin","Bubbles","Buffy","Burt","Butler","Button","Calvin","Candy","Carter","Cece","Cessa","Chandler","Chaucer","Chevy","China","Choochoo","Cisco","Claire","Cleopatra","Clooney","Coco(nut)","Connor","Cosmo","Crosby","Cupcake","Daisy","Dallas","Daphne","Delilah","Diva","Doc","Domino","Donna","Donovan","Dulus","Dutch","Ebony","Ed","Elton","Elwood","Ernie","Faith","Faya","Felix","Fig","Fiona","Foxy","Fritz","Fuse","Giblet","Gibson","Gingi","Goofy","Graysen","Greystoke","Guinness","Hershey","Holly","Honey","Huck Finn","Hudson","Hutch","Ike","Indira","Iris","Ivory","Jade","Jasmine","Jasper","Jazzy","Jeeves","Jenna","Jenne","Joy","Kai","Kalua","Kaly","Kassie","Kaya","Keanna","Keesha","Keiko","Kiefer","Kingston","Koby","Kona","Laguna","Landon","Larissa","Lefty","Leia","Lexi","Lil’bit","Lilypie","Linus","Logan","Lola","Luca","Lucy","Luke","Madonna","Malble","Malibu","Margo","Marshmellow","Marti","Max","Maya","Meadow","Mercedes","Merlot","Merry","Mia","Midnight","Midori","Mika","Milan","Mira","Mischa","Mitzi","Moby","Mochi","Monet","Monkey","Mooshie","Mozart","Mr Big","Muggles","Mulder","Mulligan","Murphy","Mylo","Nanda","Nate","Nell","Niana","Nico","Noodle","Nugget","Olive","Onyx","Otis","Owen","Ozzie","Paddington","Paisley","Paris","Parker","Paulie","Pazzo","Peanut","Pearl","Pepper","Persia","Pesci","Phoenix","Picasso","Pinot","Pipsie","Pixie","Porche","Quattro","Ramona","Redford","Reece","Rico","Robin Hood","Rocco","Rocky","Romeo","Roxie","Rufus","Rusty","Scotty","Scout","Shadow","Shaggy","Shane","Shaq","Sheba","Silas","Skip","Skitty","Skyler","Smitty","Snooky","Snoopy","Sookie","Spark","Sprite","Stitch","Strsky","Sugar","Summer","Sunny","Sushi","Sweetpea","Syrah","Tallulah","Tango","Tank","Tanner","Tatertot","Theo","Tibbs","Timber","Tink","Toast","Toffee","Tonka","Vegas","Wednesday","Wilbur","Willow","Winnie","Wolfie","Yoshiko","Zach","Zara"]
rates = [ 1500, 1000, 10_000, 50_000, 200_000, 30_000, 20_000, 3000, 4000, 5000, 7000, 150_000, 45_000, 6000 ]
known_fors = [
  "Being cute x 10",
  "Being really cute x 50",
  "Being too cute x 100",
  "Being cute and adorable x 500",
  "Being cuddly x 1000",
  "Being a good boy x 5000",
  "Being the best girl x 10000",
]

Dir.foreach('app/assets/celeb_seeds') do |dirname|
  next if dirname == '.' or dirname == '..'
  
  profile_video, profile_pic = nil, nil
  Dir.foreach('app/assets/celeb_seeds/' + dirname) do |filename|
    next if filename == '.' or filename == '..'
    if filename.end_with?('.mp4')
      profile_video = Rails.root.join("app/assets/celeb_seeds").join(dirname).join(filename)
    elsif filename.end_with?('jpg')
      profile_pic = Rails.root.join("app/assets/celeb_seeds").join(dirname).join(filename)
    else
      puts "Some error in celeb seeds video/pic attach"
    end 
  end
  
  name = cute_names[rand(0...cute_names.size)] + ' ' + cute_names[rand(0...cute_names.size)]
  nick = name.downcase.split(' ').join('.')
  rate = rates[rand(0...rates.size)]

  celeb = Celeb.new(name: name, nick: nick, rate_per_croosh: rate)

  celeb.known_for = known_fors[rand(0...known_fors.length)]
  celeb.password = 'password123'
  celeb.password_confirmation = 'password123'
  celeb.save!
  
  celeb.profile_pic.attach(io: File.open(profile_pic), filename: File.basename(profile_pic))
  celeb.profile_video.attach(io: File.open(profile_video), filename: File.basename(profile_video))

  puts celeb.nick
end


req_texts = [
  "It's my girlfriend's first year anniversary at the gym. Help her with a pep talk please.",
  "Just want to connect with you :)",
  "My brother has joined a theatre group. Give him a hearty congrats and wish him luck.",
  "I ran 10km today. Thanks to your inspiration. Would love a kudos from you.",
  "You are sooooooo amazing. Make a video for me please."
]

# completed crooshes
Dir.foreach('app/assets/croosh_seeds') do |vid_path|
  next if vid_path == '.' or vid_path == '..'

  celeb = Celeb.order('RAND()').limit(1).take
  req_text = req_texts[rand(0...req_texts.size)]
  to_complete_date = Date.today - rand(4..40).days
  croosh = Croosh.create!(
    celeb: celeb,
    to_complete_date: to_complete_date,
    request_text: req_text,
    user: u,
    created_at: to_complete_date - rand(4..14).days
  )

  path_to_video = Rails.root.join("app/assets/croosh_seeds").join(vid_path)
  croosh.video.attach(io: File.open(path_to_video), filename: File.basename(path_to_video))

end

# not completed crooshes

Celeb.all.each do |celeb|
  req_text = req_texts[rand(0...req_texts.size)]
  to_complete_date = Date.today + rand(4..40).days
  croosh = Croosh.create!(
    celeb: celeb,
    to_complete_date: to_complete_date,
    request_text: req_text,
    user: u,
    created_at: Date.yesterday,
    is_request: true
  )

  [
    "Request has been sent to #{celeb.name} and we'll keep you posted. Happy Crooshin'!",
    "#{celeb.name} has accepted the croosh request and we’ll be expecting a croosh soon. Happy crooshin’!",
    "#{celeb.name} is caught up with some other work at moment, we'll follow up. Relax.",
  ].each do |update_text|
    croosh_update = CrooshUpdate.create!(update_text: update_text, croosh: croosh)
  end
  [
    "The guy also requested if you can talk about a surprise he’s planning for her other then this croosh",
    "Her name is Kiya and she'll be turning 26",
  ].each do |rm_input_text|
    RmInput.create!(croosh: croosh, input_text: rm_input_text, name: "Nitin")
  end
end