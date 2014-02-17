class EditValuePropositionPage < SitePrism::Page
  set_url "/value_propositions{/id}/edit"
  set_url_matcher /\/value_propositions\/\d+\/edit/

  element :add_step_link, "#add_step"
  # sections :steps, StepSection, ".step"

  elements :show_step_links, ".show-step"
  elements :edit_step_links, "a.edit"
  elements :delete_step_links, "a.delete"
end
