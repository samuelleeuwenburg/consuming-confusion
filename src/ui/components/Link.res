module Styles = {
  open Emotion

  let link = css({
    "cursor": "pointer",
  })
}

@react.component
let make = (~children: React.element, ~to: string, ~className: option<string>=?) => {
  let className =
    className->Belt.Option.map(c => `${c} ${Styles.link}`)->Belt.Option.getWithDefault(Styles.link)

  <span className={className} onClick={_ => RescriptReactRouter.push(to)}> children </span>
}
