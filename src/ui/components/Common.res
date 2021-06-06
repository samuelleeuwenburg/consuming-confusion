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

module Button = {
  open Emotion
  open Style
  open Style.Spacing

  let style = css({
    "border": `2px solid ${Colors.textColorLight}`,
    "padding": px(small),
    "margin": px(medium),
    "borderRadius": px(small),
    "cursor": "pointer",
    "display": "inline-block",
  })

  @react.component
  let make = (~children: React.element, ~onClick=?) => {
    switch onClick {
    | Some(onClick) => <div className={style} onClick> children </div>
    | None => <div className={style}> children </div>
    }
  }
}
