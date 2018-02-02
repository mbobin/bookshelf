Hanami::Model.migration do
  change do
    create_table :documents do
      primary_key :id
      foreign_key :version_id, :versions, null: false, on_delete: :cascade

      column :file_data,  String,   null: false
      column :sha_hash,   String,   null: false, index: true, unique: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
