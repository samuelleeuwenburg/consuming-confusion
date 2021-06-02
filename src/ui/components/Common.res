module P = {
  open Emotion
  open Style
  open Style.Spacing

  let style = css({
    "maxWidth": "600px",
    "marginBottom": px(medium),
  })

  @react.component
  let make = (~children: React.element) => {
    <p className={style}> children </p>
  }
}

module H1 = {
  open Emotion
  open Style
  open Style.Spacing

  let style = css({
    "marginBottom": px(medium),
  })

  @react.component
  let make = (~children: React.element) => {
    <h1 className={style}> children </h1>
  }
}
