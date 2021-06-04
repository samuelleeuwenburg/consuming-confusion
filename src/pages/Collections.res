module Styles = {
  open Emotion

  let wrapper = css({
    "display": "flex",
    "flexWrap": "wrap",
    "justifyContent": "space-evenly",
  })

  let image = Emotion.rawCss(`
    width: 340px;
    flex-shrink: 0;

    img {
      width: 100%;
    }

    img:last-child {
      display: none;
    }

    &:hover {
        img:first-child {
            display: none;
        }
        img:last-child {
            display: block;
        }
    }
  `)
}

let totalImages = 28

@react.component
let make = () => {
  let images = Belt.Array.range(0, totalImages)->Belt.Array.map(i => {
    let key = Belt.Int.toString(i + 1)
    <div key={key} className={Styles.image}>
      <img src={`/images/collections/${key}.jpg`} /> <img src={`/images/collections/${key}A.jpg`} />
    </div>
  })

  <div className={Styles.wrapper}> {images->React.array} </div>
}
