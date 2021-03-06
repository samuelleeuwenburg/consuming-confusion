open Common

@react.component
let make = (~socket: SocketIO.socket) => {
  <>
    <H1>
      {React.string("Is ")}
      <Em> {React.string("sale")} </Em>
      {React.string(" a sustainable concept?")}
    </H1>
    <Vote
      socket={socket} questions={[("sale.no", "NO"), ("sale.yes", "YES"), ("sale.other", "OTHER")]}
    />
  </>
}
