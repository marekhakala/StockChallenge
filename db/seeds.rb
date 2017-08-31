# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bearerFirst = Bearer.create(name: "John Brady")
bearerSecond = Bearer.create(name: "George Steward")
bearerThird = Bearer.create(name: "Martin Schmidt")

marketPriceFirst = MarketPrice.create(currency: "USD", value_cents: 300)
marketPriceSecond = MarketPrice.create(currency: "USD", value_cents: 280)
marketPriceThird = MarketPrice.create(currency: "EUR", value_cents: 220)

stockAppleFirst = Stock.create(name: "Apple", bearer: bearerFirst, market_price: marketPriceFirst)
stockAppleSecond = Stock.create(name: "Apple", bearer: bearerSecond, market_price: marketPriceFirst)
stockAppleThird = Stock.create(name: "Apple", bearer: bearerThird, market_price: marketPriceFirst)

stockAlphabetFirst = Stock.create(name: "Alphabet", bearer: bearerThird, market_price: marketPriceSecond)
stockAlphabetSecond = Stock.create(name: "Alphabet", bearer: bearerFirst, market_price: marketPriceSecond)
stockAlphabetThird = Stock.create(name: "Alphabet", bearer: bearerSecond, market_price: marketPriceSecond)

stockVolkswagenFirst = Stock.create(name: "Volkswagen", bearer: bearerThird, market_price: marketPriceThird)
stockVolkswagenSecond = Stock.create(name: "Volkswagen", bearer: bearerSecond, market_price: marketPriceThird)
stockVolkswagenThird = Stock.create(name: "Volkswagen", bearer: bearerFirst, market_price: marketPriceThird)
