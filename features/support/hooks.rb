Before('@browser') do
  @old_driver =  Capybara.current_driver

  Capybara.current_driver = :selenium
end

After('@browser') do
  Capybara.current_driver = @old_driver || :poltergeist
end