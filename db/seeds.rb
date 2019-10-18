
require 'csv'
work_failures = []
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
