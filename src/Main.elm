module Main exposing (..)

import Browser

import Html exposing (..)
import Html.Attributes exposing (..)

import Http
import Json.Decode as Decode
import Http exposing (expectJson)
import Html.Events exposing (onClick)

baseUrl = "https://api.quotable.io/"

main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- msg
type Msg
    = GetQuote
    | LoadQuote (Result Http.Error Quote)


-- Model

type alias Quote =
    { content : String
    , author : String
    , tags : List String
    }

type alias Model =
    Quote

initModel :Model
initModel =
    quote1


init : () -> (Model, Cmd Msg)
init _ =
    ( initModel
    , fetchQuote
    )

fetchQuote =
    Http.get
        { url = (baseUrl ++ "random")
        , expect = Http.expectJson LoadQuote quoteDecoder
        }


quote1 : Quote
quote1 =
    { content = "El mas callado es el que menos habla"
    , author = "nose"
    , tags = ["nose", "nose"]
    }

cantLoad : Quote
cantLoad =
    { content = "Cant load in data ;("
    , author = "sorry"
    , tags = ["nose", "nose"]
    }


-- VIEW

view : Model -> Html Msg
view model =
    main_ []
        [ div [ class "quote-box" ]
            [ h1 [ class "quote" ] [ text model.content ]
            , h3 [ class "author" ] [text ("~ " ++ model.author) ]
            ]
        , button [ onClick GetQuote ] [ text "next" ]
        ]


-- update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        LoadQuote resp ->
            case resp of
                Ok quote -> (quote, Cmd.none)
                Err res ->  (cantLoad, Cmd.none)
        GetQuote ->
            (model, fetchQuote)


-- subscriptions (so what is this for?)
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- JSON
quoteDecoder =
    Decode.map3 Quote
        (Decode.field "content" Decode.string)
        (Decode.field "author" Decode.string)
        (Decode.field "tags" (Decode.list Decode.string))
