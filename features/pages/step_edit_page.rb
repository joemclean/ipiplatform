class StepEditPage < SitePrism::Page
  set_url "/steps{/id}/edit"

  element "resource_to_edit", "a.small-link.edit:first"
  element "resource_name", "#resource_name"
  element "resource_name_edited", "a.step_resources:first"
  element "resource_to_delete", "a.small-link.delete"
  elements "step_resource", "a.step_resource"
end
