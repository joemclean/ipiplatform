class StepsSorter < Sorter
  def item_to_find id
    Step.find(id)
  end
end
