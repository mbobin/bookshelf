Hanami::Model.migration do
  change do
    create_table :books do
      primary_key :id
      foreign_key :author_id, :authors, null: false, on_delete: :cascade

      column :name,        String,   null: false
      column :description, String
      column :tags,        "text[]", null: false, default: []
      column :isbn,        String
      column :created_at,  DateTime, null: false
      column :updated_at,  DateTime, null: false
    end
  end
end
