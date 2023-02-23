Dir[File.join(Rails.root, "db", "seeder", "*.rb")].sort.each do |seed|

  puts "seeding - #{seed}. loading seeds, for real!"

  load seed
end