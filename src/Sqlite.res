module Database = {
  type t
  type x

  @module("sqlite3") @new external new: (string, (x) => unit) => t = "Database"

  @send external run: (t, string) => unit = "run"
  @send external runArgs: (t, string, {..}) => unit = "run"

  @send external close: t => unit = "close"
}

