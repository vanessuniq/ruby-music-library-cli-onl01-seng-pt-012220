require 'pry'

class MusicLibraryController
  
  extend Concerns::Findable
  
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end
  
  def call
    user_input = ''
     while  user_input != 'exit'
    puts ("Welcome to your music library!")
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    user_input = gets.chomp
      case user_input
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
        
      end
    end
    
  end
  
  def list_songs
    Song.all.uniq.sort {|a, b| a.name <=> b.name}.each_with_index do |s, i|
      puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end
  
  def list_artists
    Artist.all.uniq.sort{|a, b| a.name <=> b.name}.each_with_index do |a, i|
      puts "#{i + 1}. #{a.name}"
    end
  end
  
   def list_genres
    Genre.all.uniq.sort{|a, b| a.name <=> b.name}.each_with_index do |g, i|
      puts "#{i+1}. #{g.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp

    if  artist = Artist.find_by_name(user_input)
      artist.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i+1}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp

    if genre = Genre.find_by_name(user_input)
      genre.songs.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        puts "#{i+1}. #{s.artist.name} - #{s.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp.to_i
    if user_input > 0 && user_input <= Song.all.uniq.length
      song = Song.all.uniq.sort{|a, b| a.name <=> b.name}[user_input - 1 ]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
  
end