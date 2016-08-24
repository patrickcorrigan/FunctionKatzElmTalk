import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing (..)
import Task



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { pokemon : List String
  }


init :(Model, Cmd Msg)
init =
  ( Model []
  , getPokemon
  )



-- UPDATE


type Msg
  = Refresh
  | FetchSucceed (List String)
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Refresh ->
      (model, getPokemon)

    FetchSucceed pokemon ->
      (Model pokemon, Cmd.none)

    FetchFail _ ->
      (Model ["failed"], Cmd.none)
      

toLi pokemonName = li [] [text pokemonName]

-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [text "Pokedex"]
    , ul [ ] (List.map toLi model.pokemon)
    , button [ onClick Refresh ] [ text "Refresh" ]
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getPokemon : Cmd Msg
getPokemon =
  let
    url =
      "http://pokeapi.co/api/v2/pokemon"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodePokemonJson url)

pokemonNameDecoder : Decoder String
pokemonNameDecoder =
  object1 identity ("name" := string)

decodePokemonJson =
  Json.at ["results"] (Json.list pokemonNameDecoder)
