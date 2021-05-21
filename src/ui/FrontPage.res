module FrontPageLink = {
  module Styles = {
    open Style
    open Emotion

    type align = Left | Right

    let link = (a: align) =>
      css({
        "width": "282px",
        "display": "inline-block",
        "textAlign": if a == Left {
          "left"
        } else {
          "right"
        },
        ":lastchild": css({
          "marginRight": "0",
        }),
      })

    let superLink = css({
      "position": "relative",
      "zIndex": "2",
      "background": Colors.textColorLight,
    })
  }

  @react.component
  let make = (~to: string, ~align: option<Styles.align>=?, ~children: React.element) => {
    let url = RescriptReactRouter.useUrl().path->Belt.List.reduce("/", (acc, part) => acc ++ part)

    let align = align->Belt.Option.getWithDefault(Styles.Left)

    let (className, link) = if url == to {
      (`${Styles.superLink} ${Styles.link(align)}`, "/")
    } else {
      (Styles.link(align), to)
    }

    <Link className={className} to={link}> children </Link>
  }
}

module Styles = {
  open Emotion

  let container = css({
    "display": "flex",
    "height": "100vh",
    "width": "100%",
    "flexDirection": "column",
    "justifyContent": "space-between",
    "padding": "45px",
  })

  let top = css({
    "display": "flex",
    "justifyContent": "space-between",
  })

  let middle = css({
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "flex-start",
    "flexGrow": "1",
    "paddingTop": "72px",
  })

  let bottom = css({
    "display": "flex",
    "justifyContent": "space-between",
  })

  let middleLink = css({
    "marginBottom": "45px",
  })
}

@react.component
let make = () => {
  <div className={Styles.container}>
    <div className={Styles.top}>
      <div>
        <FrontPageLink to="/new-collections"> {React.string("New Collections")} </FrontPageLink>
        <FrontPageLink to="/sale"> {React.string("Sale")} </FrontPageLink>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <FrontPageLink align={FrontPageLink.Styles.Right} to="/wishlist">
          {React.string("Wishlist")}
        </FrontPageLink>
        <FrontPageLink align={FrontPageLink.Styles.Right} to="/shoppingbag">
          {React.string("Shoppingbag")}
        </FrontPageLink>
      </div>
    </div>
    <div className={Styles.middle}>
      <div className={Styles.middleLink}>
        <FrontPageLink to="/collections"> {React.string("Collections")} </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink to="/sustainability"> {React.string("Sustainability")} </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink to="/responsibility"> {React.string("Responsibility")} </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink to="/contact"> {React.string("Contact")} </FrontPageLink>
      </div>
    </div>
    <div className={Styles.bottom}>
      <div>
        <FrontPageLink to="/subscribe"> {React.string("Subscribe")} </FrontPageLink>
        <FrontPageLink to="/faq"> {React.string("FAQ")} </FrontPageLink>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <FrontPageLink align={FrontPageLink.Styles.Right} to="/socials">
          {React.string("[fb] [ig] [tw]")}
        </FrontPageLink>
        <FrontPageLink align={FrontPageLink.Styles.Right} to="/about">
          {React.string("About")}
        </FrontPageLink>
      </div>
    </div>
  </div>
}
