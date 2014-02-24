class ResourcesSorter < Sorter
  def item_to_find id
    Resource.find(id)
  end
end
