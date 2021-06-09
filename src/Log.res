open Sqlite.Database

type message = {
  timestamp: float,
  message: string,
  username: string,
}

let decode = (o: Js.Json.t) => {
  o
  ->Js.Json.decodeArray
  ->Belt.Option.map(a => {
    a->Belt.Array.map(o => {
      let timestamp =
        o
        ->Js.Json.decodeObject
        ->Belt.Option.flatMap(dict => dict->Js.Dict.get("timestamp"))
        ->Belt.Option.flatMap(json => json->Js.Json.decodeNumber)

      let message =
        o
        ->Js.Json.decodeObject
        ->Belt.Option.flatMap(dict => dict->Js.Dict.get("message"))
        ->Belt.Option.flatMap(json => json->Js.Json.decodeString)

      let username =
        o
        ->Js.Json.decodeObject
        ->Belt.Option.flatMap(dict => dict->Js.Dict.get("username"))
        ->Belt.Option.flatMap(json => json->Js.Json.decodeString)

      switch (timestamp, message, username) {
      | (Some(timestamp), Some(message), Some(username)) => {
          timestamp: timestamp,
          message: message,
          username: username,
        }
      | _ => {timestamp: 0.0, message: "corrupted", username: "confused"}
      }
    })
  })
}

let setupDb = db => {
  db->serialize(() => {
    db->run(`CREATE TABLE IF NOT EXISTS logs (
        id INTEGER PRIMARY KEY,
        timestamp STRING,
        message TEXT,
        username TEXT
    )`)
  })
}

let dropAllMessages = db => {
  db->serialize(() => {
    db->run(`DELETE FROM logs`)
  })
}

let saveMessage = (db, m: message) => {
  db->serialize(() => {
    db->runArgs(
      "INSERT INTO logs (timestamp, message, username) VALUES ($timestamp, $message, $username)",
      {"$timestamp": m.timestamp, "$message": m.message, "$username": m.username},
    )
  })
  db
}

let saveToDb = (db, messages: list<message>) => {
  dropAllMessages(db)
  messages->Belt.List.forEach(m => saveMessage(db, m)->ignore)
}

let getMessages = (db, fn) => {
  db->serialize(() => {
    db->all("SELECT * FROM logs", fn)
  })
}

type t = list<message>
type action = AddMessage(message) | GetServerResults(array<message>)
type updateFn = (t, action) => t

let chatSize = 200

let update = (log, action) => {
  switch action {
  | AddMessage(message) => {
      let newLog = log->Belt.List.take(chatSize + 1)->Belt.Option.getWithDefault(log)

      list{message, ...newLog}
    }
  | GetServerResults(arr) => Belt.List.fromArray(arr)
  }
}

let init = (initialState: t) => {
  let log = ref(initialState)

  let get = () => log.contents

  let set = (action: action) => {
    log := update(log.contents, action)
  }

  (get, set)
}
