require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'works.csv')
puts "Loading raw work data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
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

# seed users
USER_FILE = Rails.root.join('db', 'seed_data', 'users.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  user.joined_date = row['joined_date']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
    puts "FAILED USER ERROR: #{user.errors.messages}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

# seed votes
VOTE_FILE = Rails.root.join('db', 'seed_data', 'votes.csv')
puts "Loading raw vote data from #{VOTE_FILE}"

vote_failures = []
CSV.foreach(VOTE_FILE, :headers => true) do |row|
  vote = Vote.new
  vote.date = row['date']
  vote.user_id = row['user_id']
  vote.work_id = row['work_id']
  successful = vote.save
  if !successful
    vote_failures << vote
    puts "Failed to save vote: #{vote.inspect}"
    puts "FAILED VOTE ERROR: #{vote.errors.messages}"
  else
    puts "Created vote: #{vote.inspect}"
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"