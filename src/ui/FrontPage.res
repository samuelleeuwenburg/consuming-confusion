module Styles = {
  open Emotion
  open Style.Spacing

  let container = css({
    "display": "flex",
    "height": "100vh",
    "width": "100%",
    "flex-direction": "column",
    "justify-content": "space-between",
    "padding": px(small),
  })

  let top = css({
    "display": "flex",
    "justify-content": "space-between",
  })

  let middle = css({
    "display": "flex",
    "flex-direction": "column",
    "justify-content": "flex-start",
    "flex-grow": "1",
    "padding-top": px(large),
  })

  let bottom = css({
    "display": "flex",
    "justify-content": "space-between",
  })

  let link = css({
    "margin-right": px(medium),
    ":last-child": css({
      "margin-right": "0",
    }),
  })
}

@react.component
let make = () => {
  <div className={Styles.container}>
    <div className={Styles.top}>
      <div>
        <Link className={Styles.link} to="/new-collections">
          {React.string("New Collections")}
        </Link>
        <Link className={Styles.link} to="/sale"> {React.string("Sale")} </Link>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <Link className={Styles.link} to="/wishlist"> {React.string("Wishlist")} </Link>
        <Link className={Styles.link} to="/shoppingbag"> {React.string("Shoppingbag")} </Link>
      </div>
    </div>
    <div className={Styles.middle}>
      <Link className={Styles.link} to="/collections"> {React.string("Collections")} </Link>
      <Link className={Styles.link} to="/sustainability"> {React.string("Sustainability")} </Link>
      <Link className={Styles.link} to="/responsibility"> {React.string("Responsibility")} </Link>
      <Link className={Styles.link} to="/contact"> {React.string("Contact")} </Link>
    </div>
    <div className={Styles.bottom}>
      <div>
        <Link className={Styles.link} to="/subscribe"> {React.string("Subscribe")} </Link>
        <Link className={Styles.link} to="/faq"> {React.string("FAQ")} </Link>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <span className={Styles.link}> {React.string("[fb] [ig] [tw]")} </span>
        <Link className={Styles.link} to="/about"> {React.string("About")} </Link>
      </div>
    </div>
  </div>
}
