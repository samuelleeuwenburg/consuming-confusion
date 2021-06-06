module Styles = {
  open Emotion
  open Style
  open Style.Spacing

  let wrapper = css({
    "display": "flex",
    "flexWrap": "wrap",
    "justifyContent": "flex-start",
  })

  let image = css({
    "marginBottom": px(small),
    "marginRight": px(small),
  })
}

let totalImages = 9;

@react.component
let make = () => {
  let images = Belt.Array.range(0, totalImages)
    ->Belt.Array.shuffle
    ->Belt.Array.map(i => {
      let url = `/images/wishlist/wish${(i + 1)->Belt.Int.toString}.svg`
      <img className={Styles.image} width="280" key={url} src={url} />
    })

  <div className={Styles.wrapper}>{React.array(images)}</div>
}
