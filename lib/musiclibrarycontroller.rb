require "pry"

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    files = MusicImporter.new(path)
    files.import
  end


  def call
    puts ("Welcome to your music library!")
    puts ("To list all of your songs, enter 'list songs'.")
    puts ("To list all of the artists in your library, enter 'list artists'.")
    puts ("To list all of the genres in your library, enter 'list genres'.")
    puts ("To list all of the songs by a particular artist, enter 'list artist'.")
    puts ("To list all of the songs of a particular genre, enter 'list genre'.")
    puts ("To play a song, enter 'play song'.")
    puts ("To quit, type 'exit'.")
    puts ("What would you like to do?")
    input = gets

    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    when "exit"
      exit
    end
  end


  def list_songs
    songs = Song.all
    songs.sort_by!(&:name)
    counter = 0
    songs.each do |s|
      counter+=1
      puts "#{counter}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    artists = []
    Artist.all.each {|a| artists << a.name}
    artists = artists.uniq.sort!
    counter = 0
    artists.each do |s|
      counter+=1
      puts "#{counter}. #{s}"
    end
  end

  def list_genres
    genres = []
    Genre.all.each {|g| genres << g.name}
    genres = genres.uniq.sort!
    counter = 0
    genres.each do |g|
      counter+=1
      puts "#{counter}. #{g}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    songs = Song.all.select do |s|
              s.artist.name == input
            end
    songs.sort_by!(&:name)
    counter = 0
    songs.each do |s|
      puts "#{counter+=1}. #{s.name} - #{s.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets
    songs = Song.all.select do |s|
              s.genre.name == input
            end
    songs.sort_by!(&:name)
    counter = 0
    songs.each do |s|
      puts "#{counter+=1}. #{s.artist.name} - #{s.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets
    list_songs.find do |s|
      s.split(/\.\s|\s\-\s/)
      song_num = s[0]
      s_artist = s[1]
      song_name = s[2]
      if song_num == gets
        puts "Playing #{song_name} by #{s_artist}"
      end
  end
end
