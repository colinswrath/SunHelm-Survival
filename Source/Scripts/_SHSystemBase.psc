Scriptname _SHSystemBase extends Quest
;Base need script. Contains methods that each need system will inherit and use
;-----------------------------------------------------------------------------

;--Properties--
Actor Player

GlobalVariable Property _SHUpdateInterval Auto
GlobalVariable property _SHHungerRate auto 
GlobalVariable Property _SHThirstRate Auto
GlobalVariable Property _SHFatigueRate Auto

GlobalVariable Property _SHCurrentHungerLevel Auto
GlobalVariable Property _SHCurrentThirstLevel Auto
GlobalVariable Property _SHCurrentFatigueLevel Auto

bool Property _SHWasSleeping auto hidden
GlobalVariable Property _SHMessagesEnabled auto
GlobalVariable Property _SHNeedsDeath auto

GlobalVariable Property _SHHungerTimeStamp Auto
GlobalVariable Property _SHFatigueTimeStamp Auto
GlobalVariable Property _SHThirstTimeStamp Auto

_SunHelmMain property _SHMain auto
_SHWellBeing property _Well auto

bool property HungerWasSleeping = false auto
bool property ThirstWasSleeping = false auto

bool InJail = false


;--Local Variables--

;Called on every fired update event
Event OnUpdateGameTime()
    if(!_SHMain.isInOblivion || !_SHMain.pauseNeedsInOblivion)
        ;Jail check
        if(!InJail || !_SHMain.BeastWerewolf)
            UpdateNeed()   ;Update appropriate need
        endif

        if(_SHMain.SKSEInstalled)
            SendModEvent("_SH_UpdateWidget")
        endif
    Else
        SetTimeStamps()
    endif
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())    ;Register to update the time again
EndEvent

;Starts up a system
Function StartSystem() 
    Start()
    Utility.Wait(1) ;Give the quest time to start
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())
EndFunction

;Stops a system. Register for update is automatically unregistered on the quest's conclusion
Function StopSystem()
    if (IsRunning())
        RemoveSystemEffects()
        Stop()
    endif
EndFunction

Function PauseUpdates()
    UnregisterForUpdateGameTime()
EndFunction

Function ResumeUpdates()
    RegisterForSingleUpdateGameTime(_SHUpdateInterval.GetValue())    ;Register to update the time again
EndFunction

Event OnStoryJail(ObjectReference akGuard, Form akCrimeGroup, Location akLocation, int aiCrimeGold)
    InJail = true;
EndEvent

;Fires event when the player gets out of jail
Event OnStoryServedTime(Location akLocation, Form akCrimeGroup, int aiCrimeGold, int aiDaysJail)
    SetTimeStamps()    

    If (akLocation == "CidhnaMine01" || akLocation == "CidhnaMine02")   ;Figure out which one this is

        _SHCurrentHungerLevel.SetValue(245)
        _SHCurrentFatigueLevel.SetValue(375)
        _SHCurrentThirstLevel.SetValue(125)
    Else
        _SHCurrentHungerLevel.SetValue(165)
        _SHCurrentFatigueLevel.SetValue(205)
        _SHCurrentThirstLevel.SetValue(85)
    EndIf

    InJail = false
EndEvent

Function SetTimeStamps()
    _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
    _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
    _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
endfunction


;Utility
;Checks to see if a float is between value 1 and 2.
bool Function IsBetween(float checkVal, int valOne, int valTwo)
    If (checkVal >= valOne && checkVal < valTwo)
        return true
    EndIf
    return false
EndFunction

;Rounds a float to the nearest int
int Function Round(float number)
    If (number - (number as int)) < 0.5     ;casting a float as an int functions the same way as a math.Floor function
		Return (number as int)
	EndIf
	Return (Math.Ceiling(number) as int)
EndFunction


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Overwrites            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Will be overwritten by children
Function UpdateNeed()
    Debug.Notification("Error: UpdateNeed not overwritten!")
EndFunction

Function RemoveSystemEffects()
    Debug.Notification("Error: RemoveSystemEffects not overwritten!")
EndFunction

