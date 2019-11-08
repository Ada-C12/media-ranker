
require 'csv'

MEDIA_SEEDS_FILE = Rails.root.join('db','media_seeds.csv')
puts "Loading raw driver data from #{MEDIA_SEEDS_FILE}"

work_failures = []
CSV.foreach(MEDIA_SEEDS_FILE, :headers => true) do |input_work|
  work = Work.new
  work.category = input_work["category"]
  work.title = input_work["title"]
  work.creator = input_work["creator"]
  work.publication_year = input_work["publication_year"]
  work.description = input_work["description"]
  successful = work.save
  if successful
    puts "Created work: #{work.inspect}"
  else
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"