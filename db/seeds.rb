require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'media-seeds.csv')

work_failures = []

CSV.foreach(WORK_FILE, :headers => true) do |row|
  new_media = Work.new
  new_media.category = row["category"]
  new_media.title = row["title"]
  new_media.creator = row["creator"]
  new_media.publication_year = row["publication_year"]
  new_media.description = row["description"]
  successful = new_media.save
  
  if successful
    puts "Created new media: #{new_media.inspect}"
  else
    work_failures << new_media
    puts "Failed to save media: #{new_media.inspect}"
  end
end

puts "#{Work.count} new media records added successfully"
puts "#{work_failures.length} media records failed to save"
