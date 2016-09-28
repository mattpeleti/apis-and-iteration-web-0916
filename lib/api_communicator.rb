require 'rest-client'
require 'JSON'
require 'pry'


def character_hash
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def find_character(character)
   character_hash.values.last.find do |character_hash_element|
     character_hash_element["name"].downcase == character.downcase
   end
end

def get_character_movies_from_api(character)
     find_character(character)["films"].map { |url| JSON.parse(RestClient.get(url))}

end



def parse_character_movies(character)

  # get_character_movies_from_api(character).each_with_index {|hash, index| puts "#{index + 1}. #{hash["title"]}"}
  character.each_with_index {|hash, index| puts "#{index + 1}. #{hash["title"]}"}


end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
