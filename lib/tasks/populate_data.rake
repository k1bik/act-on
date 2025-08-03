# rails db:populate
namespace :db do
  task populate: :environment do
    10.times do |i|
      location = Location.create!(address: "Address #{i + 1}")

      20.times do |j|
        product = Product.create!(
          location:,
          name: "Product #{j + 1}",
          description: "Description for product #{j + 1}",
          price: rand(100..10_000)
        )
      end
    end

    puts "Done!"
  end
end
