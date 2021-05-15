module Styles = {
  open Emotion
  open Style.Spacing

  let wrapper = css({
    "margin": "auto",
    "padding": px(medium),
    "maxWidth": "820px",
  })

  let chat = css({
    "height": "420px",
    "color": "inherit",
    "border": "4px solid",
    "padding": px(medium),
    "borderRadius": px(small),
  })

  let chatScrollWrapper = css({
    "height": "100%",
    "overflowY": "scroll",
  })

  let input = css({
    "fontSize": "18px",
    "padding": px(small),
  })

  let button = css({
    "fontSize": "18px",
    "padding": px(small),
  })

  let highlight = css({
    "color": "white",
  })
}

@get external getValue: Dom.element => string = "value"
@set external setValue: (Dom.element, string) => unit = "value"
@send external scrollTo: (Dom.element, int, int) => unit = "scrollTo"
@send external focus: Dom.element => unit = "focus"

let generateUsername = () => {
  let id = (Js.Math.random() *. 10000.)->Js.Math.floor
  `ConfusedConsumer#${id->Belt.Int.toString}`
}

@react.component
let make = (~socket: SocketIO.socket, ~username: string) => {
  let (log, setLog) = React.useState(_ => None)
  let input = React.useRef(Js.Nullable.null)
  let chat = React.useRef(Js.Nullable.null)

  React.useEffect(() => {
    switch chat.current->Js.Nullable.toOption {
    | Some(element) => element->scrollTo(0, 90000)
    | None => ()
    }

    if log == None {
      socket->SocketIO.emit("get_log", ())
    }

    let handleLog = (log: list<Log.message>) => {
      setLog(_ => Some(log))
    }

    socket->SocketIO.on("get_log", handleLog)

    Some(() => socket->SocketIO.off("get_log", handleLog))
  })

  let onClick = _ => {
    switch input.current->Js.Nullable.toOption {
    | Some(input) => {
        let message = Js.Dict.empty()
        Js.Dict.set(message, "message", Js.Json.string(input->getValue))
        Js.Dict.set(message, "username", Js.Json.string(username))

        socket->SocketIO.emit("add_message", Js.Json.object_(message))
        input->setValue("")
        input->focus
      }
    | _ => ()
    }
  }

  let messages = log->Belt.Option.map(log => {
    log
    ->Belt.List.map(m => {
      let key = `${m.timestamp->Belt.Float.toString}${m.message}`
      let className = if m.username == username {
        Styles.highlight
      } else {
        ""
      }

      <div className={className} key={key}> {React.string(`[${m.username}]: ${m.message}`)} </div>
    })
    ->Belt.List.reverse
    ->Belt.List.toArray
    ->React.array
  })

  <div className={Styles.wrapper}>
    <div className={Styles.chat}>
      <div className={Styles.chatScrollWrapper} ref={ReactDOM.Ref.domRef(chat)}>
        {messages->Belt.Option.getWithDefault(React.null)}
      </div>
    </div>
    <input className={Styles.input} type_="text" ref={ReactDOM.Ref.domRef(input)} />
    <button className={Styles.button} onClick={onClick}> {React.string("send")} </button>
  </div>
}
