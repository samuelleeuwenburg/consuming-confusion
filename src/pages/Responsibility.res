open Common

@react.component
let make = (~socket: SocketIO.socket) => {
  <>
    <H1>
      {React.string("Who is ")}
      <Em> {React.string("Responsible")} </Em>
      {React.string(" for sustainability?")}
    </H1>
    <P>
      {React.string(
        "Why do I feel responsible for change? Within the sustainability discourse there is a constant debate as to who has and who should take responsibility and who should be blamed. As consumers we were held responsible by political changes in the 1980s. In which they believed human needs and solutions are best achieved through the market, not the government, civil society or collective action. We can question the effectiveness of ethical products if we are tempted to buy products that appear green but actually aren't. Who is responsible but who should be responsible?",
      )}
    </P>
    <Vote
      socket={socket}
      questions={[
        ("responsibility.consumers", "Consumers"),
        ("responsibility.eduction", "Education"),
        ("responsibility.politics", "Politics"),
        ("responsibility.retail", "Retail"),
        ("responsibility.brands", "Brands"),
        ("responsibility.designers", "Designers"),
        ("responsibility.manufacturing", "Manufacturing companies"),
        ("responsibility.noone", "No one"),
        ("responsibility.everyone", "Everyone"),
      ]}
    />
  </>
}
