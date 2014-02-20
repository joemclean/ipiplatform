include ApplicationHelper

module StepsHelper
  def item_to_find id
    Step.find(id)
  end
end
