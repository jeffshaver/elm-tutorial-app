module Msgs exposing (..)

import Http
import Models exposing (Player, PlayerId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | ChangeNewPlayerName String
    | CreatePlayer Player
    | DeletePlayer PlayerId
    | OnPlayerCreate (Result Http.Error Player)
    | OnPlayerDelete (Result Http.Error String)
    | OnPlayerSave (Result Http.Error Player)
