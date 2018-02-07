class ImportLogRepository < Hanami::Repository
  def from_last_to_first
    import_logs.order { created_at.desc }
  end
end
