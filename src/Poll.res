open Sqlite.Database

type poll = {
  id: string,
  votes: int,
}

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

let decode = (o: Js.Json.t) => {
  o
  ->Js.Json.decodeArray
  ->Belt.Option.map(a => {
    a->Belt.Array.map(o => {
      let id =
        o
        ->Js.Json.decodeObject
        ->Belt.Option.flatMap(dict => dict->Js.Dict.get("id"))
        ->Belt.Option.flatMap(json => json->Js.Json.decodeString)

      let votes =
        o
        ->Js.Json.decodeObject
        ->Belt.Option.flatMap(dict => dict->Js.Dict.get("votes"))
        ->Belt.Option.flatMap(json => json->Js.Json.decodeNumber)
        ->Belt.Option.map(Belt.Float.toInt)

      switch (id, votes) {
      | (Some(id), Some(votes)) => {id: id, votes: votes}
      | _ => {id: "corrupt data", votes: 0}
      }
    })
  })
}

let setVotes = (db, poll: poll) => {
  db->serialize(() => {
    db->runArgs(
      "UPDATE polls SET votes = $votes WHERE id = $id",
      {"$votes": poll.votes, "$id": poll.id},
    )
  })
  db
}

let saveToDb = (db, polls: array<poll>) => {
  polls->Belt.Array.forEach(poll => setVotes(db, poll)->ignore)
}

let getResults = (db, fn) => {
  db->serialize(() => {
    db->all("SELECT * FROM polls", fn)
  })
}

type t = array<poll>
type action = Vote(string) | GetServerResults(array<poll>)
type updateFn = (t, action) => t

let update = (polls, action) => {
  switch action {
  | Vote(id) =>
    polls->Belt.Array.reduce([], (xs, x) => {
      if x.id == id {
        xs->Belt.Array.concat([{id: id, votes: x.votes + 1}])
      } else {
        xs->Belt.Array.concat([x])
      }
    })
  | GetServerResults(polls) => polls
  }
}

let init = (initialState: t) => {
  let polls = ref(initialState)

  let get = () => polls.contents

  let set = (action: action) => {
    polls := update(polls.contents, action)
  }

  (get, set)
}
