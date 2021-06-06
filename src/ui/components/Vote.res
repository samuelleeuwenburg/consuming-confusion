open Common

type result = {
  id: string,
  votes: float,
}

@react.component
let make = (~socket: SocketIO.socket, ~questions: array<(string, string)>) => {
  let (hasVoted, setHasVoted) = React.useState(_ => false)
  let (results, setResults) = React.useState(_ => None)

  let vote = React.useCallback(q => {
    socket->SocketIO.emit("vote", q)
    socket->SocketIO.emit("get_results", ())
    setHasVoted(_ => true)
  })

  React.useEffect(() => {
    open Chart
    let handleLog = (results: array<result>) => {
      let filtered = results->Belt.Array.reduce([], (xs, x) => {
        switch questions->Js.Array2.find(((id, _)) => id == x.id) {
        | Some((_, name)) => xs->Belt.Array.concat([{value: x.votes, name: name}])
        | None => xs
        }
      })

      setResults(_ => Some(filtered))
    }

    if results == None {
      socket->SocketIO.emit("get_results", ())
    }

    socket->SocketIO.on("get_results", handleLog)

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
  | (true, Some(data)) => <Chart data={data} />
  | _ => React.array(buttons)
  }
}
