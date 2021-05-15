module PageNotFound = {
  module Styles = {
    open Emotion

    let wrapper = css({
      "display": "flex",
      "height": "100vh",
      "width": "100%",
      "justifyContent": "center",
      "alignItems": "center",
    })
  }

  @react.component
  let make = () => {
    <div className={Styles.wrapper}> <h1> {React.string("404")} </h1> </div>
  }
}

module Styles = {
  open Emotion
  open Style

  let pageWrapper = css({
    "background": Colors.bgColorDark,
    "color": Colors.textColorLight,
    "position": "absolute",
    "top": "0",
    "left": "0",
    "height": "100vh",
    "width": "100%",
    "overflow": "scroll",
  })
}

@react.component
let make = () => {
  let socket = React.useRef(SocketIO.Client.io())
  let username = React.useRef(Chat.generateUsername())
  let url = RescriptReactRouter.useUrl()

  let page = switch url.path {
  | list{"contact"} => Some(<Chat socket={socket.current} username={username.current} />)
  | list{} => None
  | _ => Some(<PageNotFound />)
  }

  <div>
    <FrontPage />
    {page
    ->Belt.Option.map(page => <div className={Styles.pageWrapper}> page </div>)
    ->Belt.Option.getWithDefault(React.null)}
  </div>
}
