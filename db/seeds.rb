require 'csv'

WORK_FILE = Rails.root.join('db', 'media-seeds.csv')
USER_FILE = Rails.root.join('db', 'user-seeds.csv')

puts "Loading raw media data from #{WORK_FILE}"

works_failures = []

CSV.foreach(WORK_FILE, :headers => true) do |row|
  work_object = Work.new
  work_object.category = row['category']
  work_object.title = row['title']
  work_object.creator = row['creator']
  work_object.publication_year = row['publication_year']
  work_object.description = row['description']
  successful = work_object.save
  
  if !successful
    works_failures << work_object
    puts "Failed to save work: #{work_object.errors.inspect}"
  else
    puts "Created work object: #{work_object.inspect}"
  end
end

user_failures = []

CSV.foreach(USER_FILE, :headers => true) do |row|
  puts row.inspect
  user = User.new 
  user.username = row['username'].chomp
  successful = user.save 
  
  if !successful 
    user_failures << user 
    puts "Failed to save user: #{user.errors.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{Work.count} works records"
puts "#{works_failures.length} work failed to save"