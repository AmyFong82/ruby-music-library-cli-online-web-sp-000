require "pry"

class Song
  extend Concerns::Findable
  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil,  genre = nil)
    @name = name
    if artist
       self.artist=(artist)
    end
    if genre
      self.genre=(genre)
    end
    save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  # def self.find_by_name(name)
  #   self.all.find {|s| s.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   if !self.find_by_name(name)
  #     create(name)
  #   elses
  #     self.find_by_name(name)
  #   end
  # end


  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !genre.songs.find {|s| s == self}
      genre.songs << self
    end
  end

  def genre
    @genre
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Song.new(name)
  end

  def self.new_from_filename(filename)
    parsed_filename = filename.chomp(".mp3").split(/\s\-\s/)
    song_name = parsed_filename[1]
    artist_name = parsed_filename[0]
    genre_name = parsed_filename[2]
    song = Song.find_or_create_by_name(song_name)
    song.artist=(Artist.find_or_create_by_name(artist_name))
    song.genre=(Genre.find_or_create_by_name(genre_name))
    song
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
  end

end
