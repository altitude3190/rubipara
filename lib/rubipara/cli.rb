require 'thor'

module Rubipara
  class CLI < Thor

    desc 'kashikoma [<word>]', "Let's say 'Kashikoma!' together! With an option <word>, Lala says the word!"
    def kashikoma(word = 'Kashikoma!')
      kashikoma = Rubipara::AA.new(:kashikoma, word: word)
      aa = kashikoma.get_aa # return an array whose elements contain each line in AA
      aa.each {|line| puts line }
    end

    desc 'character [<name>]', "Show names of characters. With an option <name>, show the character's profile"
    def character(name = nil)
      if name
        begin
          character = Rubipara::Character.new(name)
          puts_character_profile character
        rescue Rubipara::Character::NotFoundError => e
          puts e.message
        end
      else
        Rubipara::Character.all.each {|character| puts_character_name character }
      end
    end

    desc 'profile', 'Show profiles of all characters'
    def profile
      Rubipara::Character.all.each {|character| puts_character_profile character }
    end

    desc 'epiqsode [<num>]', 'List pripara anime episodes. With an option <num>, show the No.<num> episode'
    def episode(episode_num = nil)
      if episode_num
        begin
          episode = Rubipara::Episode.new(episode_num)
          puts_episode_info episode
        rescue Rubipara::Episode::NotFoundError => e
          puts e.message
        end
      else
        Rubipara::Episode.all.each {|episode| puts_episode_info episode }
      end
    end

    private

    def puts_character_profile(character)
      puts "\n"
      puts "#{character.name} プロフィール"
      puts "名前\t: #{character.name}"
      puts "声優\t: #{character.cv}"
      puts "学年\t: #{character.grade}"
      puts "チーム\t: #{character.team}"
      puts "口癖\t: #{character.fav_phrase}"
      puts "\n"
    end

    def puts_character_name(character)
      puts "#{character.en_name}\t: #{character.name}"
    end

    def puts_episode_info(episode)
      puts "第#{sprintf("%02d", episode.episode_num)}話\t#{episode.title}"
    end

  end
end
