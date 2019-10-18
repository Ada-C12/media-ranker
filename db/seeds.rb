# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.read(Rails.root.join('db', 'media-seeds.csv'), headers: true).each do |row|
  t = Work.new(row.to_hash)
  successful = t.save
  if !successful 
    work_failures << work
    puts "failed to save work : #{work.inspect}"
  else
    puts "#{t.id}, #{t.title} saved"
  end 
end 
