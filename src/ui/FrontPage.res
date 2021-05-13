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
        <a className={Styles.link} href="#"> {React.string("New Collections")} </a>
        <a className={Styles.link} href="#"> {React.string("Sale")} </a>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <a className={Styles.link} href="#"> {React.string("Wishlist")} </a>
        <a className={Styles.link} href="#"> {React.string("Shoppingbag")} </a>
      </div>
    </div>
    <div className={Styles.middle}>
      <a className={Styles.link} href="#"> {React.string("Collections")} </a>
      <a className={Styles.link} href="#"> {React.string("Sustainability")} </a>
      <a className={Styles.link} href="#"> {React.string("Responsibility")} </a>
      <a className={Styles.link} href="#"> {React.string("Contact")} </a>
    </div>
    <div className={Styles.bottom}>
      <div>
        <a className={Styles.link} href="#"> {React.string("Subscribe")} </a>
        <a className={Styles.link} href="#"> {React.string("FAQ")} </a>
      </div>
      <div> {React.string("The Sustainable Choice")} </div>
      <div>
        <a className={Styles.link} href="#"> {React.string("[fb] [ig] [tw]")} </a>
        <a className={Styles.link} href="#"> {React.string("About")} </a>
      </div>
    </div>
  </div>
}
