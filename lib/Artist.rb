require 'pry'
class Artist
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    self.new(name).tap {|object| object.save}
  end
  
  def add_song(song)
    song.artist = self unless song.artist != nil
    @songs << song unless @songs.include?(song)
  end
  
  def genres
    self.songs.collect {|song| song.genre}.uniq
  end
  
  
    
end