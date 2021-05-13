module PageNotFound = {
  module Styles = {
    open Emotion

    let wrapper = css({
      "display": "flex",
      "height": "100vh",
      "width": "100%",
      "justify-content": "center",
      "align-items": "center",
    })
  }

  @react.component
  let make = () => {
    <div className={Styles.wrapper}> <h1> {React.string("404")} </h1> </div>
  }
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{} => <FrontPage />
  | _ => <PageNotFound />
  }
}
