open Common

module Styles = {
  open Emotion
  let wrapper = css({
    "height": "68vh",
    "display": "flex",
    "flexDirection": "column",
  })

  let chatWrapper = css({
    "maxHeight": "70%",
    "position": "relative",
    "flexGrow": "2",
  })
}

@react.component
let make = (~socket: SocketIO.socket, ~username: string) => {
  <div className={Styles.wrapper}>
    <H1>
      {React.string("To ~ have ~ ")}
      <Em> {React.string("contact")} </Em>
      {React.string(" ~ Sharing")}
    </H1>
    <P>
      {React.string(
        "To have contact and eliminate impersonal forms, we can share and engage in a real conversation here. Share your knowledge, ideas, dreams, values and struggles.",
      )}
    </P>
    <div className={Styles.chatWrapper}> <Chat socket={socket} username={username} /> </div>
  </div>
}
