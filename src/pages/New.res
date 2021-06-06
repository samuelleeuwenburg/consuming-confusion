open Common

@react.component
let make = (~socket: SocketIO.socket) => {
  <>
    <H1>
      {React.string("Is ")}
      <Em> {React.string("new")} </Em>
      {React.string(" a sustainable concept?")}
    </H1>
    <Vote
      socket={socket} questions={[("new.no", "NO"), ("new.yes", "YES"), ("new.other", "OTHER")]}
    />
  </>
}
