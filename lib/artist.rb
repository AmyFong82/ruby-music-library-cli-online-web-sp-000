require "pry"

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

  def add_song(song)
    if !song.artist
      song.artist = self
    end
    if !@songs.find {|s| s == song}
      @songs << song
    end
  end

  def genres
    genres_collection = []
    self.songs.select do |s|
      genres_collection << s.genre
    end
    genres_collection.uniq
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Artist.new(name)
  end

end
