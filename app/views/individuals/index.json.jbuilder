json.array!(@individuals) do |individual|
  json.extract! individual, :id, :f_name, :l_name, :role, :dob, :active, :bg_check_id, :contact_id
  json.url individual_url(individual, format: :json)
end
