class DocumentRepository < Hanami::Repository
  prepend DocumentAttachment.repository(:file)

  associations do
    belongs_to :version
  end

  def exists?(sha_hash)
    !!documents.select(:id).where(sha_hash: sha_hash).one
  end
end
