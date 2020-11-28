;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname PRKF__SHMiscActivations_052EE749 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SHMain.CarriageTravelled = True
Utility.Wait(13)
_SHMain.CarriageTravelled = false
if(_SHMain.FirstPersonMessages)
    _SHMain._SHCarriageTravelFirst.Show()
Else
    _SHMain._SHCarriageTravel.Show()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SHMain.BedrollSleep = true
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
    Actor Player = Game.GetPlayer()

    ;Check bottles
    int meadCount
    meadCount = Player.GetItemCount(_SHEmptyMeadMisc)
    if(meadCount > 0)
        Player.RemoveItem(_SHEmptyMeadMisc,meadCount)
    endif

    int wineCount
    wineCount = Player.GetItemCount(_SHEmptyWineMisc)
    if(wineCount > 0)
        Player.RemoveItem(_SHEmptyWineMisc,wineCount)
    endif

    int sujammaCount
    sujammaCount = Player.GetItemCount(_SHEmptySujammaMisc)
    if(sujammaCount > 0)
        Player.RemoveItem(_SHEmptySujammaMisc,sujammaCount)
    endif

    int skinCount
    skinCount = Player.GetItemCount(_SHMain._SHWaterskinEmpty)
    if(skinCount > 0)
        Player.RemoveItem(_SHMain._SHWaterskinEmpty,skinCount)
    endif

    if(meadCount > 0 || wineCount > 0 || sujammaCount > 0 || skinCount > 0)
        _SHWellFill.Play(Player)
    endif

    if(skinCount > 0)
        Player.AddItem(_SHMain._SHWaterskin_3, skinCount)
    endif

    if(meadCount > 0)
        Player.AddItem(_SHWaterBottleMead, meadCount)
    endif

    if(wineCount > 0)
        Player.AddItem(_SHWaterBottleWine, wineCount)
    endif

    if(sujammaCount > 0)
        Player.AddItem(_SHSujammaWaterBottle, sujammaCount)
    endif

    _SHDrink.Play(Player)
    if(!_SHMain.Vampire || _SHMain.VampireNeedsOption == 3)
        if(_SHMain.Thirst.IsRunning())
            _SHMain.Thirst.DecreaseThirstLevel(40)
        endif
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

Sound property _SHDrink auto
Sound property _SHWellFill auto
