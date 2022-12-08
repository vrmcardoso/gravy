# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
puts "Starting..."

puts "Cleaning database..."
Rank.destroy_all
Restaurant.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating restaurants and dishes..."

user1 = User.create(
   email: "vasco@gmail.com",
   password: "111111",
   first_name: "Vasco",
   last_name: "Cardoso",
   address: "Le Wagon Lisboa"
)

user2 = User.create(
  email: "miguel@gmail.com",
  password: "111111",
  first_name: "Miguel",
  last_name: "Silva",
  address: "Rua Marcos Portugal, Lisboa Portugal"
)

user3 = User.create(
  email: "ze@gmail.com",
  password: "111111",
  first_name: "Ze",
  last_name: "Manel",
  address: "Arroios"
)
puts "Creating categories..."
#Italian
#pasta
category1 = Category.create(
  cuisine: "Italian",
  food_type: "Pasta",
  name: "Spaghetti Bolognese"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905623/development/bollognese_in1elq.jpg'
file = URI.open(photo_url)
category1.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category1.save

category2 = Category.create(
  cuisine: "Italian",
  food_type: "Pasta",
  name: "Carbonara"
)
photo_url = 'https://www.pingodoce.pt/wp-content/uploads/2015/03/esparguete-a-carbonara.jpg'
file = URI.open(photo_url)
category2.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category2.save



#Italian
#pizza
category4 = Category.create(
  cuisine: "Italian",
  name: "Pizza Margherita",
  food_type: "Pizza"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905689/development/pizza_marguerita_qatjha.jpg'
file = URI.open(photo_url)
category4.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category4.save

category5 = Category.create(
  cuisine: "Italian",
  name: "Pizza Diavola",
  food_type: "Pizza"
)
photo_url = 'https://www.silviocicchi.com/pizzachef/wp-content/uploads/2015/03/d2.jpg'
file = URI.open(photo_url)
category5.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category5.save



# Francesinha
category6 = Category.create(
  name: "Francesinha",
  cuisine: "Portuguese"
)
photo_url = 'https://res.cloudinary.com/dmndhddgf/image/upload/v1669905810/development/francesinha_uy2g1l.webp'
file = URI.open(photo_url)
category6.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category6.save



#Seafood
#arroz de marisco
category7 = Category.create(
  cuisine: "Portuguese",
  name: "Arroz de Marisco",
  food_type: "Seafood"
)
photo_url = 'https://amodadoflavio.pt/ophaboah/2018/02/okarrzino-1024x683.jpg'
file = URI.open(photo_url)
category7.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category7.save



#Grill
#frango
category8 = Category.create(
  name: "Frango",
  cuisine: "Portuguese",
  food_type: "Grill"
)
photo_url = 'https://img.cybercook.com.br/receitas/216/frango-assado-para-microondas-1-840x480.jpeg?q=75'
file = URI.open(photo_url)
category8.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category8.save

#Asian
#sushi
category9 = Category.create(
  name: "Sushi",
  cuisine: "Asian",
  food_type: "Sushi"
)
photo_url = 'https://www.nit.pt/wp-content/uploads/2019/07/aea6de9cbaee9d2704dcf81f4a194991-754x394.jpg'
file = URI.open(photo_url)
category9.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category9.save



#Asian
#ramen

category10 = Category.create(
  name: "Ramen",
  cuisine: "Asian",
  food_type: "Ramen"
)
photo_url = 'https://www.pingodoce.pt/wp-content/uploads/2017/05/ramen.jpg'
file = URI.open(photo_url)
category10.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category10.save

category11 = Category.create(
  name: "Bifana",
  cuisine: "Portuguese",
  food_type: "Bifana"
)
photo_url = 'https://www.mundoportugues.pt/wp-content/uploads/sites/3/2019/06/1-bifanas-a-portuguesa.jpg'
file = URI.open(photo_url)
category11.photo.attach(io: file, filename: "food", content_type: "image/jpg")
category11.save



puts "Creating restaurants..."
zerozero = Restaurant.create(
  name: "ZeroZero",
  address: "R. da Escola Politécnica 32, 1250-102 Lisboa",
  latitude: "38.718202500000004",
  longitude: "-9.148499843657909"
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/0b/af/30/09/zerozero.jpg'
file = URI.open(photo_url)
zerozero.photo.attach(io: file, filename: "food", content_type: "image/jpg")
zerozero.save

dish_margarita = Dish.create(
  name: "Pizza Margarita",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: zerozero.id,
  category_id: category4.id,
)
photo_url = 'https://i0.wp.com/anamariabraga.globo.com/wp-content/uploads/2020/08/pizza-margherita.jpg?fit=1200%2C675&ssl=1'
file = URI.open(photo_url)
dish_margarita.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_margarita.save

carbonara = Dish.create(
  name: "Carbonara",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: zerozero.id,
  category_id: category2.id,
)
photo_url = 'https://conteudo.imguol.com.br/c/entretenimento/d0/2020/04/03/spaghetti-alla-carbonara-1585940968110_v2_3x4.jpg'
file = URI.open(photo_url)
carbonara.photo.attach(io: file, filename: "food", content_type: "image/jpg")
carbonara.save

bolonhesa = Dish.create(
  name: "Esparguete À Bolonhesa",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: zerozero.id,
  category_id: category1.id,
)
photo_url = 'https://recipetineats.com/wp-content/uploads/2018/07/Spaghetti-Bolognese.jpg'
file = URI.open(photo_url)
bolonhesa.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bolonhesa.save

dish_diavola = Dish.create(
  name: "Pizza Diavola",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: zerozero.id,
  category_id: category5.id,
)
photo_url = 'https://thepizzaheaven.com/wp-content/uploads/2021/07/Pizza-Diavola.jpg'
file = URI.open(photo_url)
dish_diavola.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_diavola.save

restaurant_category1 = RestaurantCategory.create(
  restaurant_id: zerozero.id,
  category_id: category4.id,
  points: 0
)

restaurant_category1 = RestaurantCategory.create(
  restaurant_id: zerozero.id,
  category_id: category2.id,
  points: 0
)

restaurant_category1 = RestaurantCategory.create(
  restaurant_id: zerozero.id,
  category_id: category1.id,
  points: 0
)

restaurant_category1 = RestaurantCategory.create(
  restaurant_id: zerozero.id,
  category_id: category5.id,
  points: 0
)



james_oliver = Restaurant.create(
  name: "Jamie Oliver",
  address: "Praça Luís de Camões, Lisboa",
  latitude: "38.710569",
  longitude: "-9.143421846805392"
)
photo_url = 'https://lisboacool.com/sites/default/files/styles/ny_article_horizontal__w720xh480_watermark/public/imagens/artigos/destaque_22.jpg?itok=myrn9hoM'
file = URI.open(photo_url)
james_oliver.photo.attach(io: file, filename: "food", content_type: "image/jpg")
james_oliver.save

dish_margarita = Dish.create(
  name: "Pizza Margarita",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: james_oliver.id,
  category_id: category4.id,
)
photo_url = 'https://media.istockphoto.com/id/1133727757/pt/foto/picking-slice-of-pepperoni-pizza.jpg?s=612x612&w=0&k=20&c=hwiw-reg5HMLLx3AG0MZ9Y27gewglYfZZGl7aljjPTI='
file = URI.open(photo_url)
dish_margarita.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_margarita.save

carbonara = Dish.create(
  name: "Carbonara",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: james_oliver.id,
  category_id: category2.id,
)
photo_url = 'https://www.acasaencantada.com.br/wp-content/uploads/2021/03/casaencantada_capablog_macarrao-carbonara-1200x900.png'
file = URI.open(photo_url)
carbonara.photo.attach(io: file, filename: "food", content_type: "image/jpg")
carbonara.save

bolonhesa = Dish.create(
  name: "Esparguete À Bolonhesa",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: james_oliver.id,
  category_id: category1.id,
)
photo_url = 'https://www.cookingclassy.com/wp-content/uploads/2022/05/bolognese-2.jpg'
file = URI.open(photo_url)
bolonhesa.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bolonhesa.save

dish_diavola = Dish.create(
  name: "Pizza Diavola",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: james_oliver.id,
  category_id: category5.id,
)
photo_url = 'https://cardapio.menu/storage/media/dishes_main/1300217/conversions/dish_thumbnail.jpg'
file = URI.open(photo_url)
dish_diavola.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_diavola.save

restaurant_category2 = RestaurantCategory.create(
  restaurant_id: james_oliver.id,
  category_id: category4.id,
  points: 0
)

restaurant_category2 = RestaurantCategory.create(
  restaurant_id: james_oliver.id,
  category_id: category2.id,
  points: 0
)

restaurant_category2 = RestaurantCategory.create(
  restaurant_id: james_oliver.id,
  category_id: category1.id,
  points: 0
)

restaurant_category2 = RestaurantCategory.create(
  restaurant_id: james_oliver.id,
  category_id: category5.id,
  points: 0
)











capricciosa = Restaurant.create(
  name: "Capricciosa",
  address: "Doca de Santo Amaro",
  latitude: "38.7010441",
  longitude: "-9.1756283"
)
photo_url = 'https://capricciosa.com.pt/wp-content/uploads/2018/12/capricciosa_docas_mm_vDNk7.jpg'
file = URI.open(photo_url)
capricciosa.photo.attach(io: file, filename: "food", content_type: "image/jpg")
capricciosa.save

dish_margarita = Dish.create(
  name: "Pizza Margarita",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: capricciosa.id,
  category_id: category4.id,
)
photo_url = 'https://cookieandkate.com/images/2021/07/classic-margherita-pizza.jpg'
file = URI.open(photo_url)
dish_margarita.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_margarita.save

carbonara = Dish.create(
  name: "Carbonara",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: capricciosa.id,
  category_id: category2.id,
)
photo_url = 'https://realfood.tesco.com/media/images/472x310-SpaghettiCarbonara-09980632-3c7f-4780-a018-74a21d853709-0-472x310.jpg'
file = URI.open(photo_url)
carbonara.photo.attach(io: file, filename: "food", content_type: "image/jpg")
carbonara.save

bolonhesa = Dish.create(
  name: "Esparguete À Bolonhesa",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: capricciosa.id,
  category_id: category1.id,
)
photo_url = 'https://www.kitchensanctuary.com/wp-content/uploads/2019/09/Spaghetti-Bolognese-square-FS-0204.jpg'
file = URI.open(photo_url)
bolonhesa.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bolonhesa.save

dish_diavola = Dish.create(
  name: "Pizza Diavola",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: capricciosa.id,
  category_id: category5.id,
)
photo_url = 'https://www.pizzarecipe.org/wp-content/uploads/2019/01/Pizza-Diavola.jpg'
file = URI.open(photo_url)
dish_diavola.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dish_diavola.save

restaurant_category3 = RestaurantCategory.create(
  restaurant_id: capricciosa.id,
  category_id: category4.id,
  points: 0
)

restaurant_category3 = RestaurantCategory.create(
  restaurant_id: capricciosa.id,
  category_id: category2.id,
  points: 0
)

restaurant_category3 = RestaurantCategory.create(
  restaurant_id: capricciosa.id,
  category_id: category1.id,
  points: 0
)

restaurant_category3 = RestaurantCategory.create(
  restaurant_id: capricciosa.id,
  category_id: category5.id,
  points: 0
)











puts "Creating francesinha..."
marco = Restaurant.create(
  name: "Marco",
  address: "Santos-o-Velho, neighbourhood, Lisbon, Portugal",
  latitude: "38.7010441",
  longitude: "-9.1756283"
)
photo_url = 'https://restaurantemarco.pt/wp-content/uploads/2020/05/famalicao.jpg'
file = URI.open(photo_url)
marco.photo.attach(io: file, filename: "food", content_type: "image/jpg")
marco.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: marco.id,
  category_id: category6.id,
)
photo_url = 'https://www.pingodoce.pt/wp-content/uploads/2017/09/francesinha.jpg'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

bifana = Dish.create(
  name: "Bifana",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: marco.id,
  category_id: category11.id,
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/1a/90/b0/69/20200110-134958-largejpg.jpg'
file = URI.open(photo_url)
bifana.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bifana.save

restaurant_category4 = RestaurantCategory.create(
  restaurant_id: marco.id,
  category_id: category6.id,
  points: 0
)

restaurant_category4 = RestaurantCategory.create(
  restaurant_id: marco.id,
  category_id: category11.id,
  points: 0
)


cervejaria_moderna = Restaurant.create(
  name: "Dote Cervejaria Moderna",
  address: "R.Barata Salgeuiro 37A, Lisbon, Portugal",
  latitude: "38.7139559",
  longitude: "-9.133939801739865"
)
photo_url = 'https://dote.pt/wp-content/uploads/2021/10/expo@2x.jpg'
file = URI.open(photo_url)
cervejaria_moderna.photo.attach(io: file, filename: "food", content_type: "image/jpg")
cervejaria_moderna.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: cervejaria_moderna.id,
  category_id: category6.id,
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/09/6b/85/a8/dote-cervejaria-moderna.jpg'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

restaurant_category19 = RestaurantCategory.create(
  restaurant_id: cervejaria_moderna.id,
  category_id: category6.id,
  points: 0
)


dom_tacho = Restaurant.create(
  name: "Dom Tacho",
  address: "R. David de Sousa, Lisbon, Portugal",
  latitude: "38.745634550000005",
  longitude: "-9.135989071524346"
)
photo_url = 'https://s3-media0.fl.yelpcdn.com/bphoto/W2giKdkL4ITSjZ83vaoexg/348s.jpg'
file = URI.open(photo_url)
dom_tacho.photo.attach(io: file, filename: "food", content_type: "image/jpg")
dom_tacho.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: dom_tacho.id,
  category_id: category6.id,
)
photo_url = 'https://static.mygon.com/ImageAdapterV2/campaign/20443/campaign1.jpg?width=760&height=506'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

restaurant_category20 = RestaurantCategory.create(
  restaurant_id: dom_tacho.id,
  category_id: category6.id,
  points: 0
)


visconde = Restaurant.create(
  name: "O Visconde",
  address: "R. Visconde Seabra 2, Lisbon, Portugal",
  latitude: "38.7601717",
  longitude: "-9.157865759465485"
)
photo_url = 'https://10619-2.s.cdn12.com/rests/original/505_186722291.jpg'
file = URI.open(photo_url)
visconde.photo.attach(io: file, filename: "food", content_type: "image/jpg")
visconde.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: true,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: visconde.id,
  category_id: category6.id,
)
photo_url = 'https://ncultura.pt/wp-content/uploads/2022/03/Francesinha-a-moda-do-Porto-para-fazer-em-casa-01.jpg'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

restaurant_category21 = RestaurantCategory.create(
  restaurant_id: visconde.id,
  category_id: category6.id,
  points: 0
)



taberna_londrina = Restaurant.create(
  name: "Taberna Londrina",
  address: "Santos-o-Velho, neighbourhood, Lisbon, Portugal",
  latitude: "38.7010441",
  longitude: "-9.1756283"
)
photo_url = 'https://media.timeout.com/images/105553727/image.jpg'
file = URI.open(photo_url)
taberna_londrina.photo.attach(io: file, filename: "food", content_type: "image/jpg")
taberna_londrina.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: taberna_londrina.id,
  category_id: category6.id,
)
photo_url = 'https://pt.rc-cdn.community.thermomix.com/recipeimage/4u5w1r9u-a2c0d-876541-d2857-wei23vu8/cbbd4640-2e8f-4bbc-b077-25569f1b4def/main/variante-francesinha-a-porto-para-criancas.jpg'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

bifana = Dish.create(
  name: "Bifana",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: taberna_londrina.id,
  category_id: category11.id,
)
photo_url = 'https://www.airtransat.com/experiencetransat/wp-content/uploads/2018/01/bifana-sandwich-portugal-food.jpg'
file = URI.open(photo_url)
bifana.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bifana.save

restaurant_category5 = RestaurantCategory.create(
  restaurant_id: taberna_londrina.id,
  category_id: category6.id,
  points: 0
)

restaurant_category5 = RestaurantCategory.create(
  restaurant_id: taberna_londrina.id,
  category_id: category11.id,
  points: 0
)


puro = Restaurant.create(
  name: "Puro Lisboa",
  address: "R. Luciano Cordeiro 74A, 1150-217 Lisboa",
  latitude: "38.7010441",
  longitude: "-9.1756283"
)
photo_url = 'https://res.cloudinary.com/tf-lab/image/upload/restaurant/f140147a-16c5-4782-9b50-c254d841b1fa/4e1f773d-c4d0-43bb-9600-d2c58633b719.jpg'
file = URI.open(photo_url)
puro.photo.attach(io: file, filename: "food", content_type: "image/jpg")
puro.save

francesinha = Dish.create(
  name: "Francesinha",
  sum_points: 1,
  milk: true,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: puro.id,
  category_id: category6.id,
)
photo_url = 'https://www.teleculinaria.pt/wp-content/uploads/2015/04/Francesinhas-TC-4.jpg'
file = URI.open(photo_url)
francesinha.photo.attach(io: file, filename: "food", content_type: "image/jpg")
francesinha.save

bifana = Dish.create(
  name: "Bifana",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: puro.id,
  category_id: category11.id,
)
photo_url = 'https://www.portugalist.com/wp-content/uploads/bifana.jpg'
file = URI.open(photo_url)
bifana.photo.attach(io: file, filename: "food", content_type: "image/jpg")
bifana.save


restaurant_category6 = RestaurantCategory.create(
  restaurant_id: puro.id,
  category_id: category6.id,
  points: 0
)

restaurant_category6 = RestaurantCategory.create(
  restaurant_id: taberna_londrina.id,
  category_id: category11.id,
  points: 0
)


puts "Creating arroz de marisco..."
a_marisqueira_do_lis = Restaurant.create(
  name: "A Marisqueira do Lis",
  address: "Intendente",
  latitude: "38.7010441",
  longitude: "-9.1756283"
)
photo_url = 'https://lh5.googleusercontent.com/p/AF1QipMbC483CRMYL99e2tEPfArns2mGsZFqQbJQJHCp=w800-h800-n-k-no'
file = URI.open(photo_url)
a_marisqueira_do_lis.photo.attach(io: file, filename: "food", content_type: "image/jpg")
a_marisqueira_do_lis.save

arroz_marisco = Dish.create(
  name: "Arroz Marisco",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: a_marisqueira_do_lis.id,
  category_id: category7.id,
)
photo_url = 'https://www.teleculinaria.pt/wp-content/uploads/2017/09/arroz-de-marisco.jpg'
file = URI.open(photo_url)
arroz_marisco.photo.attach(io: file, filename: "food", content_type: "image/jpg")
arroz_marisco.save

restaurant_category7 = RestaurantCategory.create(
  restaurant_id: a_marisqueira_do_lis.id,
  category_id: category7.id,
  points: 0
)

ramiro = Restaurant.create(
  name: "Ramiro",
  address: "Av. Alm. Reis 1H",
  latitude: "38.73269195",
  longitude: "-9.134296991782723"
)
photo_url = 'https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,q_auto,f_auto/restaurant/0aeaa48a-a3d0-42fc-a149-ea1936a0a03b/7b0b5c8b-cea6-44e5-a42b-27730defa88c.png'
file = URI.open(photo_url)
ramiro.photo.attach(io: file, filename: "food", content_type: "image/jpg")
ramiro.save

arroz_marisco = Dish.create(
  name: "Arroz Marisco",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: ramiro.id,
  category_id: category7.id,
)
photo_url = 'https://www.foodfromportugal.com/content/uploads/2017/08/arroz-marisco.jpg'
file = URI.open(photo_url)
arroz_marisco.photo.attach(io: file, filename: "food", content_type: "image/jpg")
arroz_marisco.save

restaurant_category8 = RestaurantCategory.create(
  restaurant_id: ramiro.id,
  category_id: category7.id,
  points: 0
)


oceanos5 = Restaurant.create(
  name: "5 Oceanos",
  address: "Doca de Santo Amaro",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/1d/24/f4/0d/sala-10-andar.jpg'
file = URI.open(photo_url)
oceanos5.photo.attach(io: file, filename: "food", content_type: "image/jpg")
oceanos5.save

arroz_marisco = Dish.create(
  name: "Arroz Marisco",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: oceanos5.id,
  category_id: category7.id,
)
photo_url = 'https://ruralea.com/wp-content/uploads/2022/04/aqualusa-receita-arroz-de-marisco-min-e1651318224122.jpg'
file = URI.open(photo_url)
arroz_marisco.photo.attach(io: file, filename: "food", content_type: "image/jpg")
arroz_marisco.save

restaurant_category9 = RestaurantCategory.create(
  restaurant_id: oceanos5.id,
  category_id: category7.id,
  points: 0
)

puts "Creating frango..."
frangasqueira = Restaurant.create(
  name: "Frangasqueira Nacional",
  address: "Tv. Monte do Carmo 19, 1200-276 Lisboa",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://eatingtheworld.files.wordpress.com/2015/01/frangasqueira.jpg?w=584&h=428'
file = URI.open(photo_url)
frangasqueira.photo.attach(io: file, filename: "food", content_type: "image/jpg")
frangasqueira.save

frango = Dish.create(
  name: "Frango",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: frangasqueira.id,
  category_id: category8.id,
)
photo_url = 'https://www.pingodoce.pt/wp-content/uploads/2016/06/frango-assado-no-forno.jpg'
file = URI.open(photo_url)
frango.photo.attach(io: file, filename: "food", content_type: "image/jpg")
frango.save

restaurant_category10 = RestaurantCategory.create(
  restaurant_id: frangasqueira.id,
  category_id: category8.id,
  points: 0
)

vira_frangos = Restaurant.create(
  name: "VIRA Frangos Pinheiro Chagas",
  address: "R. Pedro Nunes 41, 1050-172 Lisboa",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://www.nit.pt/wp-content/uploads/2021/04/27c911f2b4b6f9003c0da83357946b8c.jpg'
file = URI.open(photo_url)
vira_frangos.photo.attach(io: file, filename: "food", content_type: "image/jpg")
vira_frangos.save

frango = Dish.create(
  name: "Frango",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: vira_frangos.id,
  category_id: category8.id,
)
photo_url = 'https://www.colherdepau.net/wp-content/uploads/2021/03/26219596_174952219904944_3535145634622898468_n.jpg'
file = URI.open(photo_url)
frango.photo.attach(io: file, filename: "food", content_type: "image/jpg")
frango.save

restaurant_category11 = RestaurantCategory.create(
  restaurant_id: vira_frangos.id,
  category_id: category8.id,
  points: 0
)

valenciana = Restaurant.create(
  name: "À Valenciana",
  address: "R. Marquês da Fronteira",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://magnolia-portugal.dunegestion.com/public/magnolia-portugal/23063_a_valenciana_2.jpg'
file = URI.open(photo_url)
valenciana.photo.attach(io: file, filename: "food", content_type: "image/jpg")
valenciana.save

frango = Dish.create(
  name: "Frango",
  sum_points: 1,
  milk: false,
  eggs: false,
  peanuts: false,
  shellfish: false,
  wheat: false,
  soy: false,
  price: rand(10..20),
  restaurant_id: valenciana.id,
  category_id: category8.id,
)
photo_url = 'https://www.vaqueiro.pt/-/media/Project/Upfield/Whitelabels/Vaqueiro-PT/Assets/Recipes/sync-images/def48bd0-06a8-4f01-aae9-48f29996e220.jpg?rev=56e98b1fcfd548eea16c0b0476b2e1e1&w=1600'
file = URI.open(photo_url)
frango.photo.attach(io: file, filename: "food", content_type: "image/jpg")
frango.save

restaurant_category12 = RestaurantCategory.create(
  restaurant_id: valenciana.id,
  category_id: category8.id,
  points: 0
)


puts "Creating sushi..."
confraria = Restaurant.create(
  name: "Confraria",
  address: "Portugal, R. do Alecrim 12A, 1200-161 Lisboa",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/0f/8b/83/65/confraria.jpg'
file = URI.open(photo_url)
confraria.photo.attach(io: file, filename: "food", content_type: "image/jpg")
confraria.save
sushi = Dish.create(
  name: "Sushi",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: true,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: confraria.id,
  category_id: category9.id,
)
photo_url = 'https://offloadmedia.feverup.com/lisboasecreta.co/wp-content/uploads/2021/01/07045753/%40edosushiparquedasnacoes.jpg'
file = URI.open(photo_url)
sushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushi.save

restaurant_category13 = RestaurantCategory.create(
  restaurant_id: confraria.id,
  category_id: category9.id,
  points: 0
)


uniquesushi = Restaurant.create(
  name: "Unique Sushi Lab",
  address: "Travessa do Enviado de Inglaterra 9, 1200-161 Lisboa",
  latitude: "38.7191198",
  longitude: "-9.1413288"
)
photo_url = 'https://foodandtravelportugal.pt/wp-content/uploads/2018/03/unique-sushi_0044.jpg'
file = URI.open(photo_url)
uniquesushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
uniquesushi.save
sushi = Dish.create(
  name: "Sushi",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: true,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: uniquesushi.id,
  category_id: category9.id,
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/1c/e8/d3/8d/selecao-do-chef.jpg'
file = URI.open(photo_url)
sushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushi.save

restaurant_category22 = RestaurantCategory.create(
  restaurant_id: uniquesushi.id,
  category_id: category9.id,
  points: 0
)


nuisushi = Restaurant.create(
  name: "Nui Sushi & Thai bar",
  address: "Rua Maria Andrade 64A, 1200-161 Lisboa",
  latitude: "38.723171449999995",
  longitude: "-9.13524275"
)
photo_url = 'https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,q_auto,f_auto/restaurant/ee378b4f-fd10-4792-8c7d-bce5c6e6d948/9cd8981c-43b1-4137-b654-242565949772.jpg'
file = URI.open(photo_url)
nuisushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
nuisushi.save
sushi = Dish.create(
  name: "Sushi",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: true,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: nuisushi.id,
  category_id: category9.id,
)
photo_url = 'https://res.cloudinary.com/tf-lab/image/upload/f_auto,q_auto,g_auto:subject,w_488,h_488,c_fill/customer/ee378b4f-fd10-4792-8c7d-bce5c6e6d948/74ba33ff-3dc6-4d7c-917c-ffe951da025a.jpg'
file = URI.open(photo_url)
sushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushi.save

restaurant_category23 = RestaurantCategory.create(
  restaurant_id: nuisushi.id,
  category_id: category9.id,
  points: 0
)














sakura = Restaurant.create(
  name: "Sakura",
  address: "Entrecampos",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://media-cdn.tripadvisor.com/media/photo-s/08/a8/1b/86/sakura-restaurante-japones.jpg'
file = URI.open(photo_url)
sakura.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sakura.save

sushi = Dish.create(
  name: "Sushi",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: true,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: sakura.id,
  category_id: category9.id,
)
photo_url = 'https://www.bestguide.pt/wp-content/uploads/2017/05/sushi.png'
file = URI.open(photo_url)
sushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushi.save


restaurant_category14 = RestaurantCategory.create(
  restaurant_id: sakura.id,
  category_id: category9.id,
  points: 0
)






sushicome = Restaurant.create(
  name: "SushiCome",
  address: "Entrecampos",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://lh5.googleusercontent.com/p/AF1QipMjbBr2fML_2yluZTv_9W8zXgacu0E6Ff-pTNZu=w800-h800-n-k-no'
file = URI.open(photo_url)
sushicome.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushicome.save

sushi = Dish.create(
  name: "Sushi",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: true,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: sushicome.id,
  category_id: category9.id,
)
photo_url = 'https://www.nit.pt/wp-content/uploads/2018/01/940bcc7d6d0eed8ec161fe7fec7ab2ae-754x394.jpg'
file = URI.open(photo_url)
sushi.photo.attach(io: file, filename: "food", content_type: "image/jpg")
sushi.save

restaurant_category15 = RestaurantCategory.create(
  restaurant_id: sushicome.id,
  category_id: category9.id,
  points: 0
)



puts "Creating ramen..."
panda = Restaurant.create(
  name: "Panda Cantina",
  address: "Marquês de Pombal",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://www.evasoes.pt/files/2019/02/33673733_GI3012019REINALDORODRIGUES27_WEB_resultado-960x640_c.jpg'
file = URI.open(photo_url)
panda.photo.attach(io: file, filename: "food", content_type: "image/jpg")
panda.save

ramen = Dish.create(
  name: "Ramen",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: panda.id,
  category_id: category10.id,
)
photo_url = 'https://mlbeacsiwa9k.i.optimole.com/cb:iANQ~34e3e/w:2000/h:864/q:mauto/https://www.mizkanchef.com/wp-content/uploads/2020/09/ramen-tonkotsu.jpg'
file = URI.open(photo_url)
ramen.photo.attach(io: file, filename: "food", content_type: "image/jpg")
ramen.save

restaurant_category16 = RestaurantCategory.create(
  restaurant_id: panda.id,
  category_id: category10.id,
  points: 0
)




ajitama = Restaurant.create(
  name: "Ajitama",
  address: "Marquês de Pombal",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://images.squarespace-cdn.com/content/v1/5cf92f074317250001d34c19/1559835451329-Z6ZAPU34JQ3AIS2W79Q1/416A1270.jpg?format=2500w'
file = URI.open(photo_url)
ajitama.photo.attach(io: file, filename: "food", content_type: "image/jpg")
ajitama.save

ramen = Dish.create(
  name: "Ramen",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: ajitama.id,
  category_id: category10.id,
)
photo_url = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Original_Ramen.jpg/1200px-Original_Ramen.jpg'
file = URI.open(photo_url)
ramen.photo.attach(io: file, filename: "food", content_type: "image/jpg")
ramen.save

restaurant_category17 = RestaurantCategory.create(
  restaurant_id: ajitama.id,
  category_id: category10.id,
  points: 0
)

honda = Restaurant.create(
  name: "Honda Ramen",
  address: "R. Joaquim Bonifácio 24",
  latitude: "38.7008001",
  longitude: "-9.1761893"
)
photo_url = 'https://media.timeout.com/images/105869705/750/422/image.jpg'
file = URI.open(photo_url)
honda.photo.attach(io: file, filename: "food", content_type: "image/jpg")
honda.save

ramen = Dish.create(
  name: "Ramen",
  sum_points: 1,
  milk: false,
  eggs: true,
  peanuts: false,
  shellfish: true,
  wheat: false,
  soy: true,
  price: rand(10..20),
  restaurant_id: honda.id,
  category_id: category10.id,
)
photo_url = 'https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/c4e7f587-e9e1-4953-b032-f58f82e91f4d/Derivates/4b8b814f-8562-4ad0-8db8-9939cb103685.jpg'
file = URI.open(photo_url)
ramen.photo.attach(io: file, filename: "food", content_type: "image/jpg")
ramen.save
restaurant_category18 = RestaurantCategory.create(
  restaurant_id: honda.id,
  category_id: category10.id,
  points: 0
)



dishes = Dish.all
restaurants = Restaurant.all
puts "writing dish recipes"
dishes.each do |dish|
  dish.recipe = Faker::Food.description
  dish.save
end
puts "writing restaurant descriptions"
restaurants.each do |restaurant|
  restaurant.description = Faker::Restaurant.description
  restaurant.save
end
puts "completed"
