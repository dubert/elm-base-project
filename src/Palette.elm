module Palette exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


-- Colors


white = rgb255 255 255 255 -- #ffffff
black = rgb255 0 0 0 -- #000000
blue = rgb255 23 23 164 -- #1717a4
transparent = rgba 1 1 1 0 -- #ffffff00


-- Fonts


serif : Attribute msg
serif =
  Font.family
    [ Font.external
      { url = "https://fonts.googleapis.com/css?family=Source+Serif+Pro:700"
      , name = "Source Serif Pro"
      }
    , Font.serif
    ]


sans : Attribute msg
sans =
  Font.family
    [ Font.external
      { url = "https://fonts.googleapis.com/css?family=Open+Sans:400,700"
      , name = "Open Sans"
      }
    , Font.sansSerif
    ]


-- Spacing helper


rhythm : Float -> Int
rhythm n =
  n * 8
    |> round


-- Typography


scaled : Int -> Int
scaled int =
  modular 16 1.25 int
    |> round


textHeader : List (Attribute msg)
textHeader =
  [ serif
  , Font.size <| scaled 3
  , Font.bold
  , Font.color black
  ]


textBody : List (Attribute msg)
textBody =
  [ sans
  , Font.size <| scaled 1
  , Font.color black
  ]


textLink : List (Attribute msg)
textLink =
  [ sans
  , Font.size <| scaled 1
  , Font.color blue
  , Font.underline
  ]


button : List (Attribute msg)
button =
  [ Background.color blue
  , Font.bold
  , Font.size <| scaled 1
  , Font.color white
  , paddingXY (rhythm 2) (rhythm 1.5)
  , Border.rounded 2
  , Border.shadow
    { offset = ( 0, 1 )
    , size = 1
    , blur = 2
    , color = rgba 0 0 0 0.24
    }
  ]