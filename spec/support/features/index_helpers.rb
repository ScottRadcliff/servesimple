module Features
  module IndexHelpers
    def index_people
      Person.import(force: true)

      # Wait for Elasticseach to index
      sleep 2
    end
  end
end
