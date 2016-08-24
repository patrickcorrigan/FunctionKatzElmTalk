import Html exposing (Html, Attribute, div, input, text, p)
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
  { content : String }

model : Model
model =
  { content = "" }


-- UPDATE

type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

-- VIEW

palindromeInput = input [ placeholder "Is palindrome?", onInput Change ] []

view : Model -> Html Msg
view model =
    if model.content /= "" then
        div [] [ 
            palindromeInput,
            p [] [ text ( toString ( isPalindrome model.content ) ) ]
        ]
    else 
        div []
        [ palindromeInput ]

