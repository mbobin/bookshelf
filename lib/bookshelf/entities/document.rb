class Document < Hanami::Entity
  include DocumentAttachment[:file]
end
