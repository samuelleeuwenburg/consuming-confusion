open Sqlite.Database

let setupDb = db => {
  db->serialize(() => {
    db
    ->run("CREATE TABLE IF NOT EXISTS polls (id TEXT PRIMARY KEY, votes INT)")
    ->run(`
        INSERT OR IGNORE INTO polls
          (id, votes)
        VALUES
          ('sale.no', 0),
          ('sale.yes', 0),
          ('sale.other', 0),
          ('new.no', 0),
          ('new.yes', 0),
          ('new.other', 0),
          ('responsibility.consumers', 0),
          ('responsibility.eduction', 0),
          ('responsibility.politics', 0),
          ('responsibility.retail', 0),
          ('responsibility.brands', 0),
          ('responsibility.designers', 0),
          ('responsibility.manufacturing', 0),
          ('responsibility.noone', 0),
          ('responsibility.everyone', 0)
    `)
  })
}

let vote = (db, id) => {
  db->serialize(() => {
    db->runArgs("UPDATE polls SET votes = votes + 1 WHERE id = $id", {"$id": id})
  })
  db
}

let getResults = (db, fn) => {
  db->serialize(() => {
    db->all("SELECT * FROM polls", fn)
  })
}
