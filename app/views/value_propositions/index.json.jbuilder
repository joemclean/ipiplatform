json.array!(@value_propositions) do |value_proposition|
  json.extract! value_proposition, :name, :description, :full_value_proposition_description
  json.url value_proposition_url(value_proposition, format: :json)
end
