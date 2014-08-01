require 'rspec'
require 'cd_shelf.rb'
require 'cd.rb'
require 'pry'

describe CD do
  it 'is initialized with a title and artist' do
    test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
    expect(test_cd).to be_an_instance_of CD
  end

  it 'allows reading of a property' do
    test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
    expect(test_cd.title).to eq "By Request Only"
  end

  it 'allows changing of property' do
    test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
    test_cd.artist = "Dokken"
    expect(test_cd.artist).to eq "Dokken"
  end

  it 'defaults the album title to Greatest Hits' do
    test_cd = CD.new({"artist" => "Ken"})
    expect(test_cd.title).to eq "Greatest Hits"
  end
end

describe Shelf do
  it 'is initialized with slots and a name' do
    test_shelf = Shelf.new({"name" => "Bob's CDs"})
    expect(test_shelf).to be_an_instance_of Shelf
  end

  it 'allows reading of a property' do
    test_shelf = Shelf.new({"name" => "Bob's CDs"})
    expect(test_shelf.name).to eq "Bob's CDs"
  end

  describe 'add_cd' do
    it 'allows you to add a cd to a shelf' do
      test_shelf = Shelf.new({"name" => "Bob's CDs"})
      test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
      test_shelf.add_cd(test_cd)
      expect(test_shelf.slots["Ken:By Request Only"]).to be_an_instance_of CD
    end

    it 'adds a property to the cd for original owner' do
      test_shelf = Shelf.new({"name" => "Bob's CDs"})
      test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
      test_shelf.add_cd(test_cd)
      expect(test_shelf.slots["Ken:By Request Only"].home_shelf).to eq "Bob's CDs"
    end
  end

  describe 'remove_cd' do
    it 'allows you to remove a cd from a shelf' do
      test_shelf = Shelf.new({"name" => "Bob's CDs"})
      test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
      test_shelf.add_cd(test_cd)
      test_shelf.remove_cd("Ken:By Request Only")
      expect(test_shelf.slots.length).to eq 0
    end
  end

  describe 'borrow_cd' do
    it 'allows you to transfer a cd to another cd shelf' do
      test_owner = Shelf.new({"name" => "Bob's CDs"})
      test_borrower = Shelf.new({"name" => "Jane's CDs"})
      test_cd = CD.new({"title" => "By Request Only", "artist" => "Ken"})
      test_owner.add_cd(test_cd)
      test_borrower.borrow_cd({"artist:title" => "Ken:By Request Only", "shelf" => "Bob's CDs"})
      expect(test_owner.slots.length).to eq 0
      expect(test_borrower.slots.length).to eq 1
    end
  end
end


