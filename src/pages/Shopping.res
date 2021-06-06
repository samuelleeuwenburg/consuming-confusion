open Emotion

let wrapper = css({
  "display": "flex",
  "alignItems": "start",
})

let image = css({
  "width": "50%",
  "maxHeight": "70vh",
})

@react.component
let make = () => {
  <div className={wrapper}>
    <img className={image} src="/images/shopping/shopping1.svg" />
    <img className={image} src="/images/shopping/shopping2.svg" />
  </div>
}
