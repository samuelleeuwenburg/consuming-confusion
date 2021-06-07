open Emotion

let wrapper = css({
  "display": "flex",
  "alignItems": "start",
  "justifyContent": "space-between",
})

let image = css({
  "maxWidth": "100%",
  "maxHeight": "70vh",
})

@react.component
let make = () => {
  <div className={wrapper}> <img className={image} src="/images/shopping/shopping.svg" /> </div>
}
