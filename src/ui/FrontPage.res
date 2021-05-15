module FrontPageLink = {
  module Styles = {
    open Style
    open Style.Spacing
    open Emotion

    let link = css({
      "marginRight": px(large),
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
  let make = (~to: string, ~children: React.element) => {
    let url = RescriptReactRouter.useUrl().path->Belt.List.reduce("/", (acc, part) => acc ++ part)

    let (className, link) = if url == to {
      (`${Styles.superLink} ${Styles.link}`, "/")
    } else {
      (Styles.link, to)
    }

    <Link className={className} to={link}> children </Link>
  }
}

module Styles = {
  open Emotion
  open Style.Spacing

  let container = css({
    "display": "flex",
    "height": "100vh",
    "width": "100%",
    "flexDirection": "column",
    "justifyContent": "space-between",
    "padding": px(small),
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
    "paddingTop": px(large),
  })

  let bottom = css({
    "display": "flex",
    "justifyContent": "space-between",
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
        <FrontPageLink to="/wishlist"> {React.string("Wishlist")} </FrontPageLink>
        <FrontPageLink to="/shoppingbag"> {React.string("Shoppingbag")} </FrontPageLink>
      </div>
    </div>
    <div className={Styles.middle}>
      <div> <FrontPageLink to="/collections"> {React.string("Collections")} </FrontPageLink> </div>
      <div>
        <FrontPageLink to="/sustainability"> {React.string("Sustainability")} </FrontPageLink>
      </div>
      <div>
        <FrontPageLink to="/responsibility"> {React.string("Responsibility")} </FrontPageLink>
      </div>
      <div> <FrontPageLink to="/contact"> {React.string("Contact")} </FrontPageLink> </div>
    </div>
    <div className={Styles.bottom}>
      <div>
        <FrontPageLink to="/subscribe"> {React.string("Subscribe")} </FrontPageLink>
        <FrontPageLink to="/faq"> {React.string("FAQ")} </FrontPageLink>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <FrontPageLink to="/socials"> {React.string("[fb] [ig] [tw]")} </FrontPageLink>
        <FrontPageLink to="/about"> {React.string("About")} </FrontPageLink>
      </div>
    </div>
  </div>
}
