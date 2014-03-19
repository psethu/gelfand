json.array!(@programs) do |program|
  json.extract! program, :id, :name, :description, :start_date, :end_date, :cmu_facilities, :off_campus_facilities, :num_minors, :num_adults_supervising, :irb_approval, :contact_id
  json.url program_url(program, format: :json)
end
