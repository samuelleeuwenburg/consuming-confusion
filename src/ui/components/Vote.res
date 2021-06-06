open Common
open Dom.Storage2

type result = {
  id: string,
  votes: float,
}

@react.component
let make = (~socket: SocketIO.socket, ~questions: array<(string, string)>) => {
  let key = questions->Belt.Array.reduce("", (xs, (x, _)) => xs ++ x)
  let (hasVoted, setHasVoted) = React.useState(_ => localStorage->getItem(key)->Belt.Option.isSome)
  let (results, setResults) = React.useState(_ => None)

  let vote = React.useCallback(q => {
    socket->SocketIO.emit("vote", q)
    localStorage->setItem(key, "voted!")
    setHasVoted(_ => true)
  })

  let handleLog = React.useCallback((results: array<result>) => {
    open Chart
    let filtered = results->Belt.Array.reduce([], (xs, x) => {
      switch questions->Js.Array2.find(((id, _)) => id == x.id) {
      | Some((_, name)) => xs->Belt.Array.concat([{value: x.votes, name: name}])
      | None => xs
      }
    })

    setResults(_ => Some(filtered))
  })

  React.useEffect(() => {
    socket->SocketIO.on("get_results", handleLog)

    if results == None {
      socket->SocketIO.emit("get_results", ())
    }

    Some(
      () => {
        socket->SocketIO.off("get_results", handleLog)
      },
    )
  })

  let buttons = questions->Belt.Array.map(((key, name)) => {
    <Button key={key} onClick={_ => vote(key)}> {React.string(name)} </Button>
  })

  switch (hasVoted, results) {
  | (false, _) => React.array(buttons)
  | (true, Some(data)) => <Chart data={data} />
  | (true, None) => React.null
  }
}
