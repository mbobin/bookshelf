class VersionRepository < Hanami::Repository
  associations do
    belongs_to :book
    has_many :documents
  end
end
