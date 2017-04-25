module Update exposing (..)

import Commands
    exposing
        ( createPlayerCmd
        , deletePlayerCmd
        , fetchPlayers
        , savePlayerCmd
        )
import Msgs exposing (Msg)
import Models exposing (Model, Player)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.ChangeNewPlayerName playerName ->
            let
                newPlayer =
                    model.newPlayer

                updatedNewPlayer =
                    { newPlayer | name = playerName }
            in
                ( { model | newPlayer = updatedNewPlayer }, Cmd.none )

        Msgs.CreatePlayer player ->
            ( model, createPlayerCmd player )

        Msgs.DeletePlayer playerId ->
            ( model, deletePlayerCmd playerId )

        Msgs.OnPlayerCreate (Ok player) ->
            let
                newPlayer =
                    model.newPlayer

                resetNewPlayer =
                    { newPlayer | name = "" }
            in
                ( { model | newPlayer = resetNewPlayer }, fetchPlayers )

        Msgs.OnPlayerCreate (Err error) ->
            ( model, Cmd.none )

        Msgs.OnPlayerDelete (Ok _) ->
            ( model, fetchPlayers )

        Msgs.OnPlayerDelete (Err err) ->
            ( model, Cmd.none )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
