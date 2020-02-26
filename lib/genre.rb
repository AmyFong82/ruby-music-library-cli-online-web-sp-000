class Genre
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

  def songs
    @songs
  end

  def artists
    artists_collectin = []
    self.songs.collect do |s|
      artists_collectin << s.artist
    end
    artists_collectin.uniq
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Genre.new(name)
  end

end
