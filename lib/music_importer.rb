require "pry"

class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files
    Dir.glob("#{path}/*.mp3").collect{|f| f.gsub("#{path}/", "")}
  end

  def import
    files.collect do |s|
      Song.create_from_filename(s)
    end
  end

end
