open Common

@react.component
let make = (~socket: SocketIO.socket, ~username: string) => {
  <>
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
    <Chat socket={socket} username={username} />
  </>
}
