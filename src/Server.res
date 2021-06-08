module Path = {
  @module("path") external resolve: (string, string) => string = "resolve"
}

open Express

let db = Sqlite.Database.new("db.sqlite3", _e => Js.log("opened db!"))
Poll.setupDb(db)

let (getLog, updateLog) = Log.init(list{})
let (getPolls, updatePoll) = Poll.init([])

let app = express()
let server = Http.createServer(app)
let io = SocketIO.Server.server(server)

db->Poll.getResults((_, data) => {
  switch Poll.decode(data) {
  | Some(p) => updatePoll(Poll.GetServerResults(p))
  | None => ()
  }
})

let tick = () => {
  let now = Js.Date.make()->Js.Date.toISOString
  Js.log(`${now} tick!`)
  Poll.saveToDb(db, getPolls())
}

io->SocketIO.Server.on("connection", socket => {
  socket->SocketIO.on("add_message", (data: Js.Json.t) => {
    let username =
      data
      ->Js.Json.decodeObject
      ->Belt.Option.flatMap(dict => dict->Js.Dict.get("username"))
      ->Belt.Option.flatMap(json => json->Js.Json.decodeString)

    let message =
      data
      ->Js.Json.decodeObject
      ->Belt.Option.flatMap(dict => dict->Js.Dict.get("message"))
      ->Belt.Option.flatMap(json => json->Js.Json.decodeString)

    switch (username, message) {
    | (Some(username), Some(message)) => {
        let timestampedMessage: Log.message = {
          timestamp: Js.Date.now(),
          username: username,
          message: message,
        }

        updateLog(Log.AddMessage(timestampedMessage))
        io->SocketIO.Server.emit("get_log", getLog())
      }
    | _ => ()
    }
  })

  socket->SocketIO.on("get_log", () => {
    socket->SocketIO.emit("get_log", getLog())
  })

  socket->SocketIO.on("vote", (id: string) => {
    updatePoll(Poll.Vote(id))
  })

  socket->SocketIO.on("get_results", () => {
    socket->SocketIO.emit("get_results", getPolls())
  })
})

App.useOnPath(
  app,
  ~path="/",
  {
    let options = Static.defaultOptions()
    Static.make("static", options) |> Static.asMiddleware
  },
)

App.get(
  app,
  ~path="*",
  Middleware.from((_next, _req, res) => {
    Response.sendFile(Path.resolve("static", "index.html"), (), res)
  }),
)

server->Http.listen(3000, () => {
  Js.log("listening on port 3000")
})

Js.Global.setInterval(tick, 3600_000)->ignore
