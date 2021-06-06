open Common

type logo = Sustainable | Confusion

module FrontPageLink = {
  module Styles = {
    open Style
    open Style.Spacing
    open Emotion

    type align = Left | Right | Center
    type position = Top | Bottom

    let link = (a: align) =>
      cx([
        css({
          "position": "relative",
          "display": "inline-block",
          "margin": switch a {
          | Left => `0 ${px(large)} 0 0`
          | Right => `0 0 0 ${px(large)}`
          | Center => "0"
          },
        }),
        rawCss("&:hover em { display: block }"),
      ])

    let superLink = css({
      "position": "relative",
      "zIndex": "2",
      "::after": css({
        "content": "''",
        "position": "absolute",
        "display": "block",
        "background": Colors.textColorLight,
        "borderRadius": "50%",
        "width": "140%",
        "height": "160%",
        "left": "-20%",
        "top": "-30%",
      }),
    })

    let children = css({
      "position": "relative",
      "zIndex": "3",
    })

    let hover = (position, align) => {
      let transform = switch (position, align) {
      | (Bottom, Left) => "translate(10%, 10%)"
      | (Bottom, Right) => "translate(-50%, 10%)"
      | (Bottom, Center) => "translate(0%, 10%)"
      | (Top, Left) => "translate(10%, -110%)"
      | (Top, Right) => "translate(-50%, -110%)"
      | (Top, Center) => "translate(0%, -110%)"
      }

      css({
        "background": Colors.bgColorDark,
        "display": "none",
        "minWidth": "180px",
        "color": Colors.textColorLight,
        "position": "absolute",
        "top": if position == Top {
          "0"
        } else {
          "100%"
        },
        "transform": transform,
        "font-style": "normal",
        "border-radius": px(tiny),
        "padding": px(tiny),
        "zIndex": "3",
      })
    }
  }

  @react.component
  let make = (
    ~to: string,
    ~textAlign: option<Styles.align>=?,
    ~hoverPosition: option<Styles.position>=?,
    ~hoverText: string,
    ~children: React.element,
  ) => {
    let url = RescriptReactRouter.useUrl().path->Belt.List.reduce("/", (acc, part) => acc ++ part)

    let textAlign = textAlign->Belt.Option.getWithDefault(Styles.Left)
    let hoverPosition = hoverPosition->Belt.Option.getWithDefault(Styles.Bottom)

    let (className, link) = if url == to {
      (`${Styles.superLink} ${Styles.link(textAlign)}`, "/")
    } else {
      (Styles.link(textAlign), to)
    }

    let children = if url == to {
      <span className={Styles.children}> children </span>
    } else {
      children
    }

    let hover = if url == "/" {
      <em className={Styles.hover(hoverPosition, textAlign)}> {React.string(hoverText)} </em>
    } else {
      React.null
    }

    <Link className={className} to={link}> children hover </Link>
  }
}

module Styles = {
  open Emotion
  open Style
  open Style.Spacing

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
    "paddingTop": "120px",
  })

  let bottom = css({
    "display": "flex",
    "justifyContent": "space-between",
    "alignItems": "center",
  })

  let middleLink = css({
    "marginBottom": px(medium),
  })

  let logoSustainable = visible =>
    css({
      "height": "20px",
      "opacity": if visible {
        "1"
      } else {
        "0"
      },
    })

  let logoConfusion = visible =>
    css({
      "height": "26px",
      "top": "-1px",
      "left": "0",
      "position": "absolute",
      "opacity": if visible {
        "1"
      } else {
        "0"
      },
    })

  let logoConsuming = visible =>
    css({
      "height": "26px",
      "top": "-1px",
      "left": "0",
      "position": "absolute",
      "zIndex": "100",
      "filter": "invert(1)",
      "opacity": if visible {
        "1"
      } else {
        "0"
      },
    })

  let image = css({
    "color": Colors.textColorLight,
    "backgroundImage": "url('/images/front.jpg')",
    "backgroundSize": "cover",
    "backgroundPosition": "50% 100%",
    "position": "absolute",
    "top": "50%",
    "left": "50%",
    "width": "70vw",
    "height": "70vh",
    "transform": "translate(-50%, -50%)",
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "space-between",
    "alignItems": "center",
    "textAlign": "center",
    "padding": px(large),
    ":hover": css({
      "backgroundImage": "url('/images/front-hover.png')",
    }),
  })

  let subTitle = css({
    "fontSize": "48px",
    "lineHeight": "100px",
    "fontFamily": Fonts.regular,
  })

  let title = css({
    "fontSize": "82px",
    "lineHeight": "100px",
    "fontFamily": Fonts.regular,
  })

  let italicHeading = css({
    "fontFamily": Fonts.heading,
  })

  let buttons = css({
    "display": "flex",
  })

  let socials = css({
    "display": "flex",
    "alignItems": "center",
  })

  let social = css({
    "display": "inline-block",
    "height": "32px",
    "marginLeft": px(tiny),
    "position": "relative",
    "top": "3px",
  })
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl().path->Belt.List.reduce("/", (acc, part) => acc ++ part)

  let (logo, setTitle) = React.useState(_ => Sustainable)

  React.useEffect(() => {
    let _ = Js.Global.setTimeout(() => setTitle(_ => Confusion), 10_000)
    None
  })

  let logoConsuming =
    <img
      className={Styles.logoConsuming(url != "/" && url != "/consuming-confusion")}
      src={`/images/consumingconfusion.svg`}
      alt="Consuming Confusion"
    />

  <div className={Styles.container}>
    <div className={Styles.image}>
      <div>
        <h2 className={Styles.subTitle}> <em> {React.string("for our future")} </em> </h2>
        <h1 className={Styles.title}>
          {React.string("Shop the ")}
          <em className={Styles.italicHeading}> {React.string("Change")} </em>
        </h1>
      </div>
      <div className={Styles.buttons}>
        <Button> {React.string("Shop Men")} </Button>
        <Button> {React.string("Shop Women")} </Button>
      </div>
    </div>
    <div className={Styles.top}>
      <div>
        <FrontPageLink hoverText="Are we collecting questions?" to="/new">
          {React.string("New Collections")}
        </FrontPageLink>
        <FrontPageLink hoverText="Is sale a sustainable concept?" to="/sale">
          {React.string("Sale")}
        </FrontPageLink>
      </div>
      <div>
        <FrontPageLink
          hoverText="What is Consuming Confusion?"
          to="/consuming-confusion"
          textAlign={FrontPageLink.Styles.Center}>
          <img
            className={Styles.logoSustainable(logo == Sustainable)}
            src={`/images/thesustainablechoice.svg`}
            alt="The Sustainable Choice"
          />
          <img
            className={Styles.logoConfusion(logo == Confusion)}
            src={`/images/consumingconfusion.svg`}
            alt="Consuming Confusion"
          />
          {logoConsuming}
        </FrontPageLink>
      </div>
      <div>
        <FrontPageLink
          hoverText="Would you wish for more?"
          textAlign={FrontPageLink.Styles.Right}
          to="/wishlist">
          {React.string("Wishlist")}
        </FrontPageLink>
        <FrontPageLink
          hoverText="What's in my bag?" textAlign={FrontPageLink.Styles.Right} to="/shoppingbag">
          {React.string("Shoppingbag")}
        </FrontPageLink>
      </div>
    </div>
    <div className={Styles.middle}>
      <div className={Styles.middleLink}>
        <FrontPageLink hoverText="Are we collecting questions?" to="/collections">
          {React.string("Collections")}
        </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink hoverText="What is sustainability?" to="/sustainability">
          {React.string("Sustainability")}
        </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink hoverText="Who is responsible for sustainability?" to="/responsibility">
          {React.string("Responsibility")}
        </FrontPageLink>
      </div>
      <div className={Styles.middleLink}>
        <FrontPageLink hoverText="Do you have a question?" to="/contact">
          {React.string("Contact")}
        </FrontPageLink>
      </div>
    </div>
    <div className={Styles.bottom}>
      <div>
        <FrontPageLink
          hoverText="Information? Reminders? Seduction?"
          hoverPosition={FrontPageLink.Styles.Top}
          to="/subscribe">
          {React.string("Subscribe")}
        </FrontPageLink>
        <FrontPageLink
          hoverText="Would you question?" hoverPosition={FrontPageLink.Styles.Top} to="/faq">
          {React.string("FAQ")}
        </FrontPageLink>
      </div>
      <div>
        <FrontPageLink
          hoverText="What is Consuming Confusion?"
          hoverPosition={FrontPageLink.Styles.Top}
          textAlign={FrontPageLink.Styles.Center}
          to="/consuming-confusion">
          <img
            className={Styles.logoSustainable(logo == Sustainable)}
            src={`/images/thesustainablechoice.svg`}
            alt="The Sustainable Choice"
          />
          <img
            className={Styles.logoConfusion(logo == Confusion)}
            src={`/images/consumingconfusion.svg`}
            alt="Consuming Confusion"
          />
          {logoConsuming}
        </FrontPageLink>
      </div>
      <div className={Styles.socials}>
        <FrontPageLink
          hoverText="Ready to go back to the confusion?"
          hoverPosition={FrontPageLink.Styles.Top}
          textAlign={FrontPageLink.Styles.Right}
          to="/social">
          <img className={Styles.social} src="/images/icons/social4.svg" />
          <img className={Styles.social} src="/images/icons/social5.svg" />
          <img className={Styles.social} src="/images/icons/social6.svg" />
        </FrontPageLink>
        <FrontPageLink
          hoverText="Who is Consuming Confusion?"
          hoverPosition={FrontPageLink.Styles.Top}
          textAlign={FrontPageLink.Styles.Right}
          to="/about">
          {React.string("About")}
        </FrontPageLink>
      </div>
    </div>
  </div>
}
