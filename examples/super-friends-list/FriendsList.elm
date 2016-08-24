import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model = { people : List Person, selectedPerson: Maybe Person}

type alias Person = {name: String, disposition: Disposition }

type Disposition = EasyGoing | Angry | Bitter

model : Model
model = { people = [{name="Julien", disposition= EasyGoing}, {name="Katie", disposition = EasyGoing}] , selectedPerson = Nothing}


-- UPDATE

type Msg
  = ViewPerson Person | Home

update : Msg -> Model -> Model
update msg model =
  case msg of
    ViewPerson p -> {model | selectedPerson = Just p}
    Home -> {model | selectedPerson = Nothing}


toLi person = li [onClick (ViewPerson person)] [text person.name]

-- VIEW

view : Model -> Html Msg
view model = 
    case model.selectedPerson of 
    Nothing -> 
        div [] [ ul [] (List.map toLi model.people)]
    Just person -> 
        div [] [ button [onClick Home] [text "Back"],  h1 [] [text person.name], h2 [] [text (toString person.disposition)]]
