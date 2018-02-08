class CloudWord < Hanami::Entity
  attributes do
    attribute :frequency, Types::Int
    attribute :word,      Types::String
  end
end
