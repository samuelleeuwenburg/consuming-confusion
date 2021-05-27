@get external getValue: Dom.element => string = "value"
@set external setValue: (Dom.element, string) => unit = "value"
@send external scrollTo: (Dom.element, int, int) => unit = "scrollTo"
@send external focus: Dom.element => unit = "focus"
@get external getKeyCode: Dom.keyboardEvent => int = "keyCode"

@scope("window") @val
external addEventListener: (string, Dom.keyboardEvent => unit) => unit = "addEventListener"
@scope("window") @val
external removeEventListener: (string, Dom.keyboardEvent => unit) => unit = "removeEventListener"

module Styles = {
  open Emotion
  open Style
  open Style.Spacing

  let wrapper = css({
    "margin": "auto",
    "padding": px(medium),
    "maxWidth": "820px",
    "border": "4px solid",
    "borderRadius": px(small),
    "padding": px(medium),
  })

  let chat = css({
    "height": "420px",
    "color": "inherit",
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

let generateUsername = () => {
  let id = (Js.Math.random() *. 10000.)->Js.Math.floor
  `ConfusedConsumer#${id->Belt.Int.toString}`
}

@react.component
let make = (~socket: SocketIO.socket, ~username: string) => {
  let (log, setLog) = React.useState(_ => None)
  let input = React.useRef(Js.Nullable.null)
  let chat = React.useRef(Js.Nullable.null)

  let submit = _ => {
    let input = input.current->Js.Nullable.toOption
    let message =
      input
      ->Belt.Option.map(i => i->getValue->Js.String.trim)
      ->Belt.Option.flatMap(s =>
        if s == "" {
          None
        } else {
          Some(s)
        }
      )

    switch (input, message) {
    | (Some(input), Some(message)) => {
        let json = Js.Dict.empty()
        Js.Dict.set(json, "message", Js.Json.string(message))
        Js.Dict.set(json, "username", Js.Json.string(username))

        socket->SocketIO.emit("add_message", Js.Json.object_(json))
        input->setValue("")
        input->focus
      }
    | _ => ()
    }
  }

  let handleKeyDown = React.useCallback(e => {
    switch e->getKeyCode {
    | 13 => submit()
    | _ => ()
    }
  })

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
    addEventListener("keydown", handleKeyDown)

    Some(
      () => {
        socket->SocketIO.off("get_log", handleLog)
        removeEventListener("keydown", handleKeyDown)
      },
    )
  })
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
    <button className={Styles.button} onClick={submit}> {React.string("send")} </button>
  </div>
}
