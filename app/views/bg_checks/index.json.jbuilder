json.array!(@bg_checks) do |bg_check|
  json.extract! bg_check, :id, :date_approved, :status, :criminal_date, :child_abuse_date, :verification_date
  json.url bg_check_url(bg_check, format: :json)
end
