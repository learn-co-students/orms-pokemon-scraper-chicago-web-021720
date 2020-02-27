class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(hash={})
        @id = hash[:id]
        @name = hash[:name]
        @type = hash[:type]
        @db = hash[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
    end

    def self.new_from_db(row)
        p_hash = {:id => row[0], :name => row[1], :type => row[2]}
        self.new(p_hash)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?;
        SQL

        db.execute(sql, id).map do |row|
            self.new_from_db(row)
        end.first
    end
end
