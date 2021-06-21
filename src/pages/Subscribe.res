open Common
open Emotion
open Style
open Style.Spacing

let wrapper = Media.medium(
  css({
    "display": "flex",
    "alignItems": "start",
  }),
)

let text = Media.medium(
  css({
    "width": "50%",
    "paddingRight": px(medium),
  }),
)

let images = Media.medium(
  css({
    "width": "50%",
    "textAlign": "center",
  }),
)

let fullImage = css({
  "width": "100%",
  "maxHeight": "50vh",
})

let image = css({
  "maxWidth": "40%",
  "marginTop": px(medium),
  "marginRight": px(medium),
  "maxHeight": "20vh",
})

@react.component
let make = () => {
  <div className={wrapper}>
    <div className={text}>
      <H1> <Em> {React.string("Subscribe?")} </Em> {React.string(" To what?")} </H1>
      <P>
        {React.string(
          "In this study you will see a multitude of 98 emails from 7 different websites in 1 month. All these websites promote sustainability. This study clarifies how much we see and receive. Consuming confusion thinks it is important to question this fastness and volume. As the speed and multiplicity in which our market operates contributes to our relationship with products. Speed can affect how we perceive things. While multiplicity makes us less focused, there is less room to ask critical questions on: sustainability, production and working conditions. The speed and variety contribute to our impulse to buy.",
        )}
      </P>
      <P>
        {React.string(
          "* The logos in the visualisations are purely used as illustration and in no way serve a commercial function",
        )}
      </P>
    </div>
    <div className={images}>
      <img className={fullImage} src="/images/subscribe/subscribe1.svg" />
      <img className={image} src="/images/subscribe/subscribe2.svg" />
      <img className={image} width="120" src="/images/subscribe/subscribe3.svg" />
    </div>
  </div>
}
