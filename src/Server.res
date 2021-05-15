module Path = {
  @module("path") external resolve: (string, string) => string = "resolve"
}

open Express

let (getLog, updateLog) = Log.init(list{})
let app = express()
let server = Http.createServer(app)
let io = SocketIO.Server.server(server)

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

        timestampedMessage->Log.AddMessage->updateLog
        io->SocketIO.Server.emit("get_log", getLog())
      }
    | _ => ()
    }
  })

  socket->SocketIO.on("get_log", () => {
    socket->SocketIO.emit("get_log", getLog())
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
