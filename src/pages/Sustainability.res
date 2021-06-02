open Common

module Styles = {
  open Emotion

  let image = css({
    "width": "25%",
  })

  let gap = css({
    "display": "inline-block",
    "width": "25%",
    "paddingTop": "25%",
  })
}

let totalImages = 32
let totalGaps = 12

@react.component
let make = () => {
  let images =
    Belt.Array.range(0, totalImages + totalGaps)
    ->Belt.Array.shuffle
    ->Belt.Array.map(i => {
      if i <= totalImages {
        let url = `/images/sustainability/${i->Belt.Int.toString}.png`
        <img className={Styles.image} key={url} src={url} />
      } else {
        <div className={Styles.gap} key={i->Belt.Int.toString} />
      }
    })

  <>
    <H1> {React.string("What is sustainability?")} </H1>
    <P>
      {React.string(
        "What is sustainability If you can even fuel your car sustainably, eat conscious meat and buy green fast fashion derived from mass production practices, things that in itself are inherently unsustainable? Sustainability is a matter of perspective.",
      )}
    </P>
    <P>
      {React.string("The perspectives are collected through")}
      <br />
      {React.string("a survey from March 2021 to May 2021.")}
    </P>
    {images->React.array}
  </>
}
