class ResourcesSorter
  def item_to_find id
    Resource.find(id)
  end

  def sort(items)
    items.each_with_index do |id, index|
      item =  item_to_find(id)
      item.position = index + 1
      item.save
    end
  end


end
