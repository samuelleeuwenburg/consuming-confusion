open Sqlite.Database

let setupDb = db => {
  db->serialize(() => {
    db
    ->run("CREATE TABLE IF NOT EXISTS polls (id TEXT PRIMARY KEY, votes INT)")
    ->run("INSERT OR IGNORE INTO polls (id, votes) VALUES ('foo', 0), ('bar', 0)")
  })
}

let vote = (db, id) => {
  db->serialize(() => {
    db->runArgs("UPDATE polls SET votes = votes + 1 WHERE id = $id", {"$id": id})
  })
  db
}

let getResults = (db, id, fn) => {
  db->serialize(() => {
    db->get("SELECT votes FROM polls WHERE id = $id", {"$id": id}, fn)
  })
}
