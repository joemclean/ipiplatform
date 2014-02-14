class EditStepPage < SitePrism::Page
  set_url "/steps{/id}/edit"

  elements "resources_to_edit", "a.edit"
  element "resource_name", "#resource_name"
  elements "resource_names", "a.step_resources"
  elements "resources_to_delete", "a.delete"
  elements "step_resource", "a.step_resource"
end
