import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

isPalindrome : String -> Bool
isPalindrome s = s == String.reverse s

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { content : String, isPalindrome : Maybe Bool}

model : Model
model =
  { content = "", isPalindrome = Nothing}


-- UPDATE

type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | isPalindrome = Just (isPalindrome newContent) }

-- VIEW

view : Model -> Html Msg
view model =
 case model.isPalindrome of 
 Nothing -> 
  div []
    [ input [ placeholder "Text to reverse", onInput Change ] []
    ]

 Just isPalindrome -> 
  div []
    [ input [ placeholder "Text to reverse", onInput Change ] []
    , div [] [ text (toString isPalindrome) ]
    ]
