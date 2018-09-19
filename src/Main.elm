port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Url exposing (Url)

import Element exposing (..)
import Element.Events exposing (..)
import Element.Input as Input

import Route exposing (..)
import Palette


-- Model


type alias Model =
  { route : Route
  , key : Nav.Key
  , uid : Int
  }

type alias Flags = Int


-- Main


main : Program Flags Model Msg
main =
  Browser.application
    { init = init
    , update = update
    , view =
      \m ->
        { title = "Elm 0.19 Base Project"
        , body = [ view m ]
        }
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged -- Url -> msg
    , onUrlRequest = UrlRequested -- UrlRequest -> msg
    }


init : Flags -> Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  let
    initModel =
      { route = routeFromUrl url
      , key = key
      , uid = flags
      }
  in
    ( initModel , Cmd.none )


-- Update


type Msg
  = NoOp
  | RouteRequested Route
  | UrlChanged Url
  | UrlRequested Browser.UrlRequest
  | Inc
  | Set Int


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
  case message of
    NoOp ->
      ( model, Cmd.none )

    RouteRequested route ->
      ( { model
        | route = route
        }
      , pushUrl model.key route
      )

    UrlChanged url ->
      let
        maybeRoute : Maybe Route
        maybeRoute =
          fromUrl url
      in
        case maybeRoute of
          Nothing ->
            ( model, Cmd.none)
          Just route ->
            ( { model
              | route = route
              }
            , Cmd.none
            )

    UrlRequested urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model
          , Nav.pushUrl model.key (Url.toString url)
          )

        Browser.External href ->
          ( model, Nav.load href )

    Inc ->
      let
        uid : Int
        uid = model.uid + 1
      in
        ( { model
          | uid = uid
          }
        , toJs <| "model.uid incremented to " ++ String.fromInt uid
        )

    Set int ->
      ( { model
        | uid = int
        }
      , toJs <| "model.uid set to " ++ String.fromInt int
      )


-- View


view : Model -> Html Msg
view model =
  layout
    []
    <| column
      [ width
        (fill
          |> minimum (Palette.rhythm 75)
          |> maximum (Palette.rhythm 125)
        )
      , centerX
      , paddingXY 0 (Palette.rhythm 8)
      , spacing <| Palette.rhythm 2
      ]
      [ row
        [ spacing <| Palette.rhythm 2 ]
        [ image
          [ width <| px <| Palette.rhythm 4
          , height <| px <| Palette.rhythm 4
          ]
          { src = "/images/logo.png"
          , description = "Elm logo"
          }
        , el
          Palette.textHeader
          <| text "Elm 0.19 Webpack Starter, featuring hot-loading"
        ]
      , paragraph
        Palette.textBody
        [ text "Click on the button below to increment the state." ]
      , paragraph
        Palette.textBody
        [ row
          [ spacing <| Palette.rhythm 2 ]
          [ Input.button
            Palette.button
            { onPress = Just Inc
            , label = text "+ 1"
            }
          , text <| "Current value: " ++ String.fromInt model.uid
          ]
        ]
      , paragraph
        Palette.textBody
        [ text "Then make a change to the source code and see how the state is retained after you recompile."
        ]
      , paragraph
        Palette.textBody
        [ text "And now don't forget to add a star to the Github repo"
        , link
          Palette.textLink
          { url = "https://github.com/dubert/elm-base-project"
          , label = text "elm-base-project"
          }
        ]
      ]



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- Ports


port toJs : String -> Cmd msg