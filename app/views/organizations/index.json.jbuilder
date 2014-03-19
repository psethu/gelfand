json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name, :is_partner, :description, :activr, :department, :contact_id
  json.url organization_url(organization, format: :json)
end
