@react.component
let make = () => {
  let socket = React.useMemo(SocketIO.Client.io)
  let username = React.useMemo(Chat.generateUsername)

  <Router socket={socket} username={username} />
}
