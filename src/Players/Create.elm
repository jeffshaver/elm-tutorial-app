module Players.Create exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)


view : Player -> Html Msg
view model =
    div []
        [ nav
        , input [ onInput Msgs.ChangeNewPlayerName, placeholder "Name", type_ "text", value model.name ] []
        , button [ onClick (Msgs.CreatePlayer model) ] [ text "Submit" ]
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ listBtn
            , text " Create Player"
            ]
        ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn-regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
