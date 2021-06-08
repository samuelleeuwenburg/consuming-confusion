module Database = {
  type t
  type error
  type result = Js.Json.t

  @module("sqlite3") @new external new: (string, error => unit) => t = "Database"

  @send external serialize: (t, unit => t) => unit = "serialize"
  @send external run: (t, string) => t = "run"
  @send external runArgs: (t, string, {..}) => t = "run"
  @send external get: (t, string, (error, result) => unit) => t = "get"
  @send external all: (t, string, (error, result) => unit) => t = "all"
  @send external close: t => unit = "close"
}
