class CD
  attr_accessor :title, :artist, :home_shelf

  def initialize(attributes)
    @title = attributes["title"] || "Greatest Hits"
    @artist = attributes["artist"]
  end
end
