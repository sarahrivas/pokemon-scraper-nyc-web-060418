require "pry"

class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  def initialize(name: , type:, hp: nil, id:,  db: )
    @name = name
    @type = type
    @hp = hp
    @db = db
    @id = id
  end

  def self.save(name, type, db)
    sql_string = <<-SQL_STRING
      INSERT into pokemon (name, type)
      VALUES (?, ?)
    SQL_STRING

    db.execute(sql_string, name, type)
  end

  def self.find(id, db)
    sql_string = <<-SQL_STRING
      SELECT name, type, hp, id FROM pokemon WHERE id = ?
    SQL_STRING

    matching_pokemon_array = db.execute(sql_string, id).flatten

    matching_pokemon_hash = {:name => matching_pokemon_array[0], :type => matching_pokemon_array[1], :hp => matching_pokemon_array[2], :id => matching_pokemon_array[3], :db => db }

    Pokemon.new(matching_pokemon_hash)
  end



end
