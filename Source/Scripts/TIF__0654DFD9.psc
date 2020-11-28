;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0654DFD9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
    Player.RemoveItem(Gold001, 10)

    ;Check bottles
    Actor Player = Game.GetPlayer()
    int meadCount
    meadCount = Player.GetItemCount(_SHEmptyMeadMisc)
    if(meadCount > 0)
        Player.RemoveItem(_SHEmptyMeadMisc,meadCount)
    endif

    int skinCount
    skinCount = Player.GetItemCount(_SHMain._SHWaterskinEmpty)
    if(skinCount > 0)
        Player.RemoveItem(_SHMain._SHWaterskinEmpty,skinCount)
    endif

    int wineCount
    wineCount = Player.GetItemCount(_SHEmptyWineMisc)
    if(wineCount > 0)
        Player.RemoveItem(_SHEmptyWineMisc,wineCount)
    endif

    int sujammaCount
    sujammaCount = Player.GetItemCount(_SHEmptySujammaMisc)

    _SHWellFill.Play(Player)

    if(meadCount > 0)
        Player.AddItem(_SHWaterBottleMead, meadCount)
    endif

    if(wineCount > 0)
        Player.AddItem(_SHWaterBottleWine, wineCount)
    endif

    if(sujammaCount > 0)
        Player.AddItem(_SHSujammaWaterBottle, sujammaCount)
    endif

    if(skinCount > 0)
        Player.AddItem(_SHMain._SHWaterskin_3, skinCount)
    endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SunHelmMain property _SHMain auto
Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHSujammaWaterBottle auto

Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto

MiscObject property Gold001 auto

Sound property _SHWellFill auto

