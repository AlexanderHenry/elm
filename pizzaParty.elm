import Html.App exposing (beginnerProgram)
import Html exposing(Attribute, Html, div, text, button, label, input, p)
import Html.Attributes exposing(value, style, placeholder)
import Html.Events exposing(onClick, onInput)
import String exposing(toFloat)

type Msg =
  NoOp
  | NumberOfPeople String
  | NumberOfPizzas String
  | NumberOfSlicesPerPizza String
  | CalculateSlicesPerPerson

-- model
type alias Model =
  { numberOfPeople: String
  , numberOfPizzas: String
  , numberOfSlicesPerPizza: String
  , slicesPerPerson: Float
  }

model: Model
model =
  { numberOfPeople = "2"
  , numberOfPizzas = "2"
  , numberOfSlicesPerPizza = "8"
  , slicesPerPerson = 8
  }

main =
  beginnerProgram {model = model, view = view, update = update}

view: Model -> Html Msg
view model =
  div [] [
    div [] [
        label [labelStyle] [text "Number of People"]
      , input [placeholder "People", onInput NumberOfPeople, value model.numberOfPeople] []
    ]
    , div [] [
        label [labelStyle] [text "Number of Pizzas"]
      , input [placeholder "Pizzas", onInput NumberOfPizzas, value model.numberOfPizzas] []
    ]
    , div [] [
        label [labelStyle] [text "Number of Slices Per Pizza"]
      , input [placeholder "Slices Per Pizza", onInput NumberOfSlicesPerPizza, value model.numberOfSlicesPerPizza] []
    ]
    , p [labelStyle] [text "Slices Per Person"]
    , p [slicesPerPersonStyle] [text (toString model.slicesPerPerson)]
    , button [buttonStyle, onClick CalculateSlicesPerPerson] [text "Calculate"]
  ]

update: Msg -> Model -> Model
update message model =
  case message of
    NoOp -> model

    NumberOfPeople p ->
      { model | numberOfPeople = p }

    NumberOfPizzas p ->
      { model | numberOfPizzas = p }

    NumberOfSlicesPerPizza s ->
      { model | numberOfSlicesPerPizza = s }

    CalculateSlicesPerPerson ->
      { model | slicesPerPerson = (calculateSlices model) }

calculateSlices: Model -> Float
calculateSlices model =
  let
    numberOfPeople = case String.toFloat model.numberOfPeople of
      Err msg -> 0.0
      Ok val -> val
    numberOfPizzas = case String.toFloat model.numberOfPizzas of
      Err msg -> 0.0
      Ok val -> val
    numberOfSlicesPerPizza = case String.toFloat model.numberOfSlicesPerPizza of
      Err msg -> 0.0
      Ok val -> val
  in
  Basics.toFloat(round ((numberOfPizzas * numberOfSlicesPerPizza) / numberOfPeople ))

labelStyle: Attribute Msg
labelStyle =
  style
    [ ("text-align", "left")
    , ("padding", "10px")
    , ("width", "200px")
    , ("display", "inline-block")
    ]

slicesPerPersonStyle: Attribute Msg
slicesPerPersonStyle =
  style
    [ ("text-align", "left")
    , ("display", "inline-block")
    ]

buttonStyle: Attribute Msg
buttonStyle =
  style
    [ ("text-align", "center")
    , ("padding", "10px")
    , ("width", "100px")
    , ("display", "block")
    , ("margin-left", "215px")
    ]
