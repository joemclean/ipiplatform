require 'spec_helper'

describe "steps/edit" do
  before(:each) do
    @step = assign(:step, stub_model(Step,
      :name => "MyString",
      :description => "MyText"
    ))
  end

end
