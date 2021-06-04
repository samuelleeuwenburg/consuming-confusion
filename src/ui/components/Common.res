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
    "fontFamily": Fonts.regular,
    "fontSize": "inherit",
  })

  @react.component
  let make = (~children: React.element) => {
    <h1 className={style}> children </h1>
  }
}

module Em = {
  open Emotion

  let style = css({
    "fontFamily": Style.Fonts.heading,
  })

  @react.component
  let make = (~children: React.element) => {
    <em className={style}> children </em>
  }
}
