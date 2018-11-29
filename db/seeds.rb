DatabaseCleaner.clean_with(:truncation)

10.times do
    User.create(name: Faker::Name.name, token: 'token')
end

20.times do
    Article.create(name: Faker::Beer.unique.name)
end

10.times do
    Restaurant.create(name: Faker::RuPaul.quote)
end

10.times do
    Supplier.create(name: Faker::Robin.unique.quote)
end

Restaurant.all.each do |r|
    Article.all.each do |a|
        r.restaurant_articles.create(article_id: a.id, selling_price: Faker::Number.between(30, 300))
    end
    Supplier.all.each do |s|
        r.supplier_restaurants.create(supplier_id: s.id, customer_number: Faker::Number.between(1, 9999999))
    end
end

Supplier.all.each do |s|
    Article.all.each do |a|
        s.supplier_articles.create(article_id: a.id, price: Faker::Number.between(30, 300), art_nr: Faker::Number.between(1, 9999999))
    end
end