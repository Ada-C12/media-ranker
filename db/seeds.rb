require 'csv'

CSV.foreach('db/media-seeds.csv', headers: true) do |row|
  row['published'] = row['publication_year']
  row.delete 'publication_year'
  Work.create row.to_h.transform_keys(&:to_sym)
end
