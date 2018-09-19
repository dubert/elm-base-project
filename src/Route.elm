module Route exposing (Route(..), fromUrl, routeFromUrl, pushUrl, replaceUrl)

import Browser.Navigation as Nav
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, (</>), top, oneOf, map, s, int)


-- Routing


type Route
  = Index
  | Integer Int
  | Example


router : Parser (Route -> a) a
router =
  oneOf
    [ map Index top
    , map Integer (int)
    , map Example (s "example")
    ]


-- Public helpers


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
  Nav.pushUrl key (routeToString route)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
  Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
  -- The RealWorld spec treats the fragment like a path.
  -- This makes it *literally* the path, so we can proceed
  -- with parsing as if it had been a normal path all along.
  { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    |> Parser.parse router


routeFromUrl : Url -> Route
routeFromUrl url =
  let
    maybeRoute : Maybe Route
    maybeRoute =
      fromUrl url
  in
    case maybeRoute of
      Nothing -> Index
      Just route -> route


-- Internal helpers


routeToString : Route -> String
routeToString route =
  case route of
    Index -> ""
    Integer int -> "#" ++ String.fromInt int
    Example -> "#example"
