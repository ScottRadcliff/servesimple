require 'csv_with_progress_bar'

namespace :import do
  # Import a CSV file of people
  #
  # This isn't really meant to be the end-all-be-all way to import, but its
  # enough to get started with development from other systems.
  #
  # ## Usage
  #
  #   rake import:csv["/Users/kmarsh/Downloads/patrons.csv"]
  #
  # Some options can be specified via environment variables:
  #   * `PERSON_ACCOUNT_ID=1`: Which account to associate the person with (required)
  #   * `PERSON_ROLE_IDS=3`: Role IDs to assign
  #
  task :csv, [:file] => [:environment] do |t, args|
    account = Account.find(ENV['PERSON_ACCOUNT_ID'])

    raise "Invalid/no account specified" unless account

    ActiveRecord::Base.transaction do
      data = File.read(args['file'])
      csv = CSV.new(data, headers: true)
      csv.extend(CSV::ProgressBar)

      csv.each do |row|
        p = Person.find_or_initialize_by(external_id: row['Patron ID'])
        p.account      = account
        p.roles        = account.roles.find(ENV['PERSON_ROLE_IDS'].split(','))
        p.name         = row['Name']
        p.address_1    = row['Address 1']
        p.address_2    = row['Address 2']
        p.address_city = row['City']
        # p.address_state
        p.address_zip  = row['Zip']
        p.save!
      end
    end
  end
end
