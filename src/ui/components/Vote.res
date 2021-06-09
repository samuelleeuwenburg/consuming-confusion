open Common
open Dom.Storage2

type result = {
  id: string,
  votes: float,
}

@react.component
let make = (
  ~socket: SocketIO.socket,
  ~questions: array<(string, string)>,
  ~polls: option<array<Poll.poll>>,
) => {
  let key = questions->Belt.Array.reduce("", (xs, (x, _)) => xs ++ x)
  let (hasVoted, setHasVoted) = React.useState(_ => localStorage->getItem(key)->Belt.Option.isSome)

  let vote = React.useCallback(q => {
    socket->SocketIO.emit("vote", q)
    localStorage->setItem(key, "voted!")
    setHasVoted(_ => true)
  })

  let buttons = questions->Belt.Array.map(((key, name)) => {
    <Button key={key} onClick={_ => vote(key)}> {React.string(name)} </Button>
  })

  let results = polls->Belt.Option.map(polls => {
    open Chart

    polls->Belt.Array.reduce([], (xs, x) => {
      switch questions->Js.Array2.find(((id, _)) => id == x.id) {
      | Some((_, name)) => xs->Belt.Array.concat([{value: x.votes->Belt.Int.toFloat, name: name}])
      | None => xs
      }
    })
  })

  switch (hasVoted, results) {
  | (false, _) => React.array(buttons)
  | (true, Some(data)) => <Chart data={data} />
  | (true, None) => React.null
  }
}
