Scriptname _SHPlayerScript extends ReferenceAlias  

_SunHelmMain property _SHMain auto
FormList property _SHAlcoholList auto
FormList property _SHSkoomaList auto
FormList property _ShBlackBooks auto
bool property stopUpdating = false auto

Armor property DA11RingOfNamira auto



Actor Player
Form consumed

Event OnPlayerLoadGame()
    ;Checking for update
    Player = Game.GetPlayer()
    ;_SHMain.SetDiseaseGameSettingString()
    _SHMain.CheckForUpdate()
EndEvent

;Event to detect alcohol and skooma
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)  
    if(akBaseObject as Potion)
        Player = Game.GetPlayer()
        consumed = akBaseObject            
        if(_SHMain._SHEnabled.GetValue() == 1)
            if(AlcoholCheck())
                _SHMain.AlcoholDrink()
            ElseIf (SkoomaCheck())
                _SHMain._SHSkoomaSpell.Cast(Player,Player)
            endif
        endif
    endif
endevent

Event OnUpdate()
    Update()
endevent

Function Update()
    if(_SHMain._SHEnabled.GetValue() == 1)
        CheckFT()
    endif
    if(!stopUpdating)
        RegisterForSingleUpdate(5 as float)
    endif
endFunction

function CheckFT()

    ;Only check if we have frostfall
    if(!_SHMain.ModComp.FrostfallInstalled)
        ObjectReference override = Game.FindClosestReferenceOfAnyTypeInListFromRef(_SHBlackBooks, Player as objectreference, 600.000)
        if override
            if !Game.IsFastTravelControlsEnabled()
                Game.EnableFastTravel(true)
            endIf
            return 

        elseif _SHMain.isRidingDragon
            if !Game.IsFastTravelControlsEnabled()
                Game.EnableFastTravel(true)
            endIf
            return 
        ElseIf (_SHMain._SHDisableFT.GetValue() == 1 && Game.IsFastTravelControlsEnabled())
            Game.EnableFastTravel(false)  
        endIf
    endif
endFunction

;Check if alcohol
bool Function AlcoholCheck()

    if(consumed.HasKeyword(_SHMain._SH_AlcoholDrinkKeyword) || _SHAlcoholList.HasForm(consumed))
        _SHMain.Thirst.DecreaseThirstLevel(20.00)
        return true
    Else
        return false
    endif

EndFunction


bool Function SkoomaCheck()
    ;If skooma restore fatigue
    if(_SHSkoomaList.HasForm(consumed))
        _SHMain.Fatigue.DecreaseFatigueLevel(15.00)
        return true
    else
        return false
    endif

EndFunction