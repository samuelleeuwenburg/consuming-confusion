module PageNotFound = {
  module Styles = {
    open Emotion

    let wrapper = css({
      "display": "flex",
      "height": "70vh",
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

module PageWrapper = {
  module Styles = {
    open Emotion
    open Style

    let pageOuterWrapper = css({
      "background": Colors.bgColorDark,
      "color": Colors.textColorLight,
      "position": "absolute",
      "top": "0",
      "left": "0",
      "height": "100vh",
      "width": "100%",
      "display": "block",
      "overflow": "scroll",
      "::before": css({
        "content": "''",
        "display": "block",
        "top": "0",
        "left": "10%",
        "width": "80%",
        "height": "15vh",
        "position": "fixed",
        "background": Colors.bgColorDark,
      }),
      "::after": css({
        "content": "''",
        "display": "block",
        "bottom": "0",
        "left": "10%",
        "width": "80%",
        "height": "15vh",
        "position": "fixed",
        "background": Colors.bgColorDark,
      }),
    })

    let pageInnerWrapper = css({
      "width": "70vw",
      "margin": "auto",
      "padding": "15vh 0",
    })

    let backLink = css({
      "zIndex": "1",
      "position": "fixed",
      "bottom": "50px",
      "right": "340px",
    })
  }

  @react.component
  let make = (~children: React.element) => {
    <div className={Styles.pageOuterWrapper}>
      <div className={Styles.pageInnerWrapper}> children </div>
      <Link className={Styles.backLink} to="/"> {React.string("Back to front")} </Link>
    </div>
  }
}

let socket = SocketIO.Client.io()

@react.component
let make = () => {
  let username = React.useRef(Chat.generateUsername())
  let (polls, setPolls) = React.useState(() => None)
  let url = RescriptReactRouter.useUrl()

  let handleNewPolls = React.useCallback((result: array<Poll.poll>) => {
    setPolls(_ => Some(result))
  })

  React.useEffect(() => {
    socket->SocketIO.on("get_results", handleNewPolls)

    if polls == None {
      socket->SocketIO.emit("get_results", ())
    }

    Some(
      () => {
        socket->SocketIO.off("get_results", handleNewPolls)
      },
    )
  })

  let page = switch url.path {
  | list{"consuming-confusion"} => Some(<Confusion />)
  | list{"about"} => Some(<About />)
  | list{"wishlist"} => Some(<Wish />)
  | list{"subscribe"} => Some(<Subscribe />)
  | list{"shoppingbag"} => Some(<Shopping />)
  | list{"new"} => Some(<New polls={polls} socket={socket} />)
  | list{"sale"} => Some(<Sale polls={polls} socket={socket} />)
  | list{"responsibility"} => Some(<Responsibility polls={polls} socket={socket} />)
  | list{"contact"} => Some(<Contact socket={socket} username={username.current} />)
  | list{"collections"} => Some(<Collections />)
  | list{"faq"} => Some(<FAQ />)
  | list{"social"} => Some(<Social />)
  | list{"sustainability"} => Some(<Sustainability />)
  | list{} => None
  | _ => Some(<PageNotFound />)
  }

  <div>
    <FrontPage />
    {page
    ->Belt.Option.map(x => <PageWrapper> x </PageWrapper>)
    ->Belt.Option.getWithDefault(React.null)}
  </div>
}
