require 'csv'

class Transaction::LoadFromCsvService

  def perform
    csv_test = File.read(Rails.root.join('lib', 'seeds', 'transactional-sample.csv'))
    csv = CSV.parse(csv_test, headers: true)

    csv.each do |row|
      hash = row.to_hash
      Transaction::HashToModelService.new(hash).perform
    end
  end
end
