class EditValuePropositionPage < SitePrism::Page
  set_url "/value_propositions{/id}/edit"
  set_url_matcher /\/value_propositions\/\d+\/edit/

  element :add_step_link, "#add_step"
  elements :steps, ".step"
end
