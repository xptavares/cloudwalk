namespace :transaction do
  desc "Load data from csv"
  task load_from_csv: :environment do
    Transaction::LoadFromCsvService.new.perform
    puts "done!"
  end
end
