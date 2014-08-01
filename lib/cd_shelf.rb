class Shelf
  attr_accessor :name, :slots
  @@shelves = {}

  def initialize(attributes)
    @name = attributes["name"]
    @slots = {}
    @@shelves[@name] = self
  end

  def add_cd(new_cd)
    new_cd.home_shelf = self.name
    @slots[new_cd.artist + ":" + new_cd.title] = new_cd
  end

  def remove_cd(old_cd)
    @slots.delete(old_cd)
  end

  def Shelf.shelves
    @@shelves
  end

  def borrow_cd(descriptors)
    @slots[descriptors["artist:title"]] = Shelf.shelves[descriptors["shelf"]].remove_cd(descriptors["artist:title"])
  end

end
