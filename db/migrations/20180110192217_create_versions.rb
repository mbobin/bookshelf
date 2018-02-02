Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :type, %w(audio azw azw1 azw3 azw4 docx epub fb2 htmlz lrf mobi pdb pdf prc rtf tpz txtz)

    create_table :versions do
      primary_key :id
      foreign_key :book_id, :books, null: false, on_delete: :cascade

      column :type,         :type,    null: false
      column :published_at, DateTime
      column :created_at,   DateTime, null: false
      column :updated_at,   DateTime, null: false
    end
  end
end
