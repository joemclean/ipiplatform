class AddResourcePage < SitePrism::Page
  set_url "/resources/add{/step_id}"

  elements :add_resource_links, ".add"
end
