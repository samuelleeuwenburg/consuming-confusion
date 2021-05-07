open Express

let app = express()

App.useOnPath(app, ~path="/", {
  let options = Static.defaultOptions()
  Static.make("static", options) |> Static.asMiddleware
})

let onListen = e =>
  switch e {
  | exception Js.Exn.Error(e) => {
      Js.log(e)
        Node.Process.exit(1)
    }
  | _ => Js.log("server started at 127.0.0.1:3000")
  }

let server = App.listen(app, ~port=3000, ~onListen, ())
