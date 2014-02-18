class ResourcesPage < SitePrism::Page
  set_url "/resources"

  element :new_resource_button, "a[id='new_resource']"

end
