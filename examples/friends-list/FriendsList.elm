import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model = { people : List Person}

type alias Person = {name: String, disposition: Disposition }

type Disposition = EasyGoing | Angry | Bitter

model : Model
model = { people = [{name="Julien", disposition=Angry}, {name="Katie", disposition=Bitter} ] }


-- UPDATE

type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change a -> model


toLi person = li [] [text person.name]

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [
     ul [] (List.map toLi model.people)
    ]
