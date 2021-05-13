module Path = {
  @module("path") external resolve: (string, string) => string = "resolve"
}

open Express

let app = express()

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

let onListen = e =>
  switch e {
  | exception Js.Exn.Error(e) => {
      Js.log(e)
      Node.Process.exit(1)
    }
  | _ => Js.log("server started at 127.0.0.1:3000")
  }

let server = App.listen(app, ~port=3000, ~onListen, ())
