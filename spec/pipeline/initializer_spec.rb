require_relative "../spec_helper"

describe Pipeline::Initializer do
  it "sets the repos" do
    expect(described_class.call).to include(
      "author_repo" => an_instance_of(AuthorRepository),
      "book_repo"   => an_instance_of(BookRepository),
      "document_repo" => an_instance_of(DocumentRepository),
      "version_repo"   => an_instance_of(VersionRepository),
    )
  end

  context "without a file path" do
    subject(:subject) { described_class.call }

    it "sets the halt flag" do
      expect(subject).to include("halted" => true)
    end

    it "sets the reason" do
      expect(subject).to include("halted_reason" => "File not found")
    end

    it "sets the halt class" do
      expect(subject).to include("halted_from" => described_class)
    end
  end

  context "without a file path" do
    subject(:subject) { described_class.call("file_path" => __FILE__) }

    it "doesn't halt" do
      expect(subject).not_to include("halted" => true)
    end
  end
end
