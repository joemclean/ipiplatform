class NewStepPage < SitePrism::Page
  set_url "/steps/new{/value_proposition_id}"

  element :save_button, "input[value='Save']"
  element :name_field_error, ".field_with_errors #step_name"
  element :name, "#step_name"
  element :description, "#step_description"
end
