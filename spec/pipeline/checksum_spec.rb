require_relative "../spec_helper"

describe Pipeline::Checksum do
  let(:file) { Tempfile.new }
  subject(:subject) { described_class.call("file_path" => file, "document_repo" => DocumentRepository.new) }

  context "without a file path" do
    it "sets the file_digest" do
      expect(subject).to include("file_digest" => a_kind_of(String))
    end
  end

  context "without a file path" do
    before do
      author = AuthorRepository.new.create(name: "Tester")
      book = BookRepository.new.create(name: "Test", tags: [], author_id: author.id)
      version = VersionRepository.new.create(book_id: book.id, type: "pdf")
      document = Document.new(file: file, version_id: version.id, sha_hash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
      document = DocumentRepository.new.create(document)
    end

    after do
      AuthorRepository.new.clear
    end

    context "it halts" do
      it { expect(subject).to include("halted" => true) }
      it { expect(subject).to include("halted_from" => described_class) }
      it { expect(subject).to include("halted_reason" => "Document already exists") }
    end
  end
end
