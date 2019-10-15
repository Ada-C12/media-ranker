require 'csv'

WORK_FILE = Rails.root.join('db', 'media-seeds.csv')

puts "Loading raw media data from #{WORK_FILE}"

works_failures = []

CSV.foreach(WORK_FILE, :headers => true) do |row|
  work_object = Work.new
  work_object.category = row['category']
  work_object.title = row['title']
  work_object.creator = row['creator']
  work_object.publication_year = row['publication']
  work_object.description = row['description']
  successful = work_object.save
  
  if !successful
    works_failures << work_object
    puts "Failed to save work: #{work_object.inspect}"
  else
    puts "Created work object: #{work_object.inspect}"
  end
end

puts "Added #{Work.count} works records"
puts "#{works_failures.length} work failed to save"