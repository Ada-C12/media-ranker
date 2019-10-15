require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media-seeds.csv')
puts "Loading raw works data from #{MEDIA_FILE}"

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.title = row['title']
  work.category = row['category']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
