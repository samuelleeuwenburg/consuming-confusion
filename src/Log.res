type message = {
  timestamp: float,
  message: string,
  username: string,
}

type t = list<message>
type action = AddMessage(message)
type updateFn = (t, action) => t

let chatSize = 20

let update = (log, action) => {
  switch action {
  | AddMessage(message) => {
      let newLog = log->Belt.List.take(chatSize + 1)->Belt.Option.getWithDefault(log)

      list{message, ...newLog}
    }
  }
}

let init = (initialState: t) => {
  let log = ref(initialState)

  let get = () => log.contents

  let set = (action: action) => {
    log := update(log.contents, action)
  }

  (get, set)
}
