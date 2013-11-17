namespace :test do

  desc 'runs all tests'
  task :all => [:unit, :cucumber] do
  end

  desc 'runs all tests with documentation'
  task :wordy => [:wordy_unit, :cucumber] do
  end

  desc 'runs spec tests'
  task :unit do
    result = system 'rspec'

    if result
      puts 'rspec tests successful'
    else
      raise 'rspec tests failed'
    end
  end

  desc 'runs rspec with --format documentation wordiness'
  task :wordy_unit do
    result = system 'rspec --format documentation'

    if result
      puts 'rspec tests successful'
    else
      raise 'rspec tests failed'
    end
  end

end
