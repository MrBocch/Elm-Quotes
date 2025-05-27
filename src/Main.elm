module Main exposing (main)

import Browser

import Html exposing (..)

main =
    Browser.sandbox
        { init = initModel
        , view = view
        , update = update
        }

-- Model

type alias Quote =
    { id : String
    , content : String
    , author : String
    , tags : List String
    , authorSlug : String
    , length : Int
    , dateAdded : String
    , dateModified : String
    }

type alias Model =
    { quotes : Quote }

initModel : Model
initModel =
    { quotes =  quote1 }

quote1 : Quote
quote1 =
    { id = "test"
    , content = "El mas callado es el que menos habla"
    , author = "nose"
    , tags = ["nose", "nose"]
    , authorSlug = "idk"
    , length = String.length "El mas callado es el que menos habla"
    , dateAdded = "2024-04-01"
    , dateModified = "2023-01-01"
    }
-- VIEW

view : Model -> Html msg
view model =
    div []
        [ h1 [] [ text model.quotes.content ]
        , h3 [] [text ("~ " ++ model.quotes.author) ]
        ]

-- update
update : msg -> Model -> Model
update msg model = model
