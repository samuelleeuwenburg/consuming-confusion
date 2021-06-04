open Common

@react.component
let make = () => {
  <>
    <H1> {React.string("I ~ don't ~ want ~ to ~ be ~ ")} <Em> {React.string("Social")} </Em> </H1>
    <P> {React.string("Sorry, no socials.")} </P>
    <P>
      {React.string("The consuming confusion website does not participate in the confusion. As it consists of questionable content, misleading information and the addictive multitude of information that social media contributes to the overall confusion.
")}
    </P>
  </>
}
