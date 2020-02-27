class Pokemon
    attr_accessor :db, :id
    attr_reader :name, :type

    def initialize(name:, type:, id: nil, db: nil)
        @name = name
        @type = type
        @id = id
        @db = db
    end

    def self.find(id, db)
        row = db.execute("SELECT * FROM pokemon WHERE id = ?", id).first
        self.new(id: row[0], name: row[1], type: row[2])
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon ( name, type ) VALUES ( ?, ? )", name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

end