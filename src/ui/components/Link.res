@react.component
let make = (~children: React.element, ~to: string, ~className: option<string>=?) => {
  let className = className->Belt.Option.getWithDefault("")

  <span className={className} onClick={_ => RescriptReactRouter.push(to)}> children </span>
}
