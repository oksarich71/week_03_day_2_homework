require('pg')

class BountyHunter

  attr_accessor(:name, :species, :bounty_value, :favourite_weapon)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i()
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i()
    @favourite_weapon = options['favourite_weapon']
  end

  def self.all()
    db = PG.connect({
     dbname: 'bounty_hunter',
     host: 'localhost'
   })
   sql = 'SELECT * FROM bounty_hunter;'

   db.prepare('all', sql)
   bounty_hashes = db.exec_prepared('all')
   db.close()
   bounty_objects = bounty_hashes.map do |bounty_hash|
     BountyHunter.new(bounty_hash)
   end
   return bounty_objects
   end

  def save()
   db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
     })

    sql = "
      INSERT INTO bounty_hunter (
        name,
        species,
        bounty_value,
        favourite_weapon
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id;
      "
          db.prepare('save', sql)
          result = db.exec_prepared('save', [@name, @species, @bounty_value, @favourite_weapon])
          db.close()

          result_hash = result[0]
          string_id = result_hash['id']
          id = string_id.to_i()
          @id = id
    end

    def self.delete_all()
       db = PG.connect({
        dbname: 'bounty_hunter',
        host: 'localhost'
      })
      sql = 'DELETE FROM bounty_hunter;'
      db.exec(sql)
      db.close()
   end

  #  def self.find(id)
  #     db = PG.connect({
  #      dbname: 'bounty_hunter',
  #      host: 'localhost'
  #    })
  #    sql = 'SELECT FROM bounty_hunter
  #    WHERE @id = id;'
  #    db.exec(sql)
  #    db.close()
  # end

    def update()
     db = PG.connect({
      dbname: 'bounty_hunter',
      host: 'localhost'
    })

    sql = "
    UPDATE bounty_hunter
    SET (
      name,
      species,
      bounty_value,
      favourite_weapon
      ) = ($1, $2, $3, $4)
      WHERE id = $5;
      "
      values = [
        @name,
        @species,
        @bounty_value,
        @favourite_weapon,
        @id
      ]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
   end
end #class end
