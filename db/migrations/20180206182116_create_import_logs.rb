Hanami::Model.migration do
  change do
    create_table :import_logs do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :data, "jsonb", null: false, default: "{}"
    end
  end
end
