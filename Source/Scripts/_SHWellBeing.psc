Scriptname _SHWellBeing extends Quest

Actor Player

_SunHelmMain property _SHMain auto

GlobalVariable property _SHWellBeingLevel auto
GlobalVariable property _SHMessagesEnabled auto
GlobalVariable Property _SHWellBeingTimeStamp Auto
GlobalVariable Property _SHWellBeingTutEnabled auto

Spell property _SHWellBeing0 auto
Spell property _SHWellBeing1 auto
Spell property _SHWellBeing2 auto
Spell property _SHWellBeing3 auto

;int Property CurrentWellBeingStage auto hidden

Message property _SHWellBeingMessage0 auto
Message property _SHWellBeingMessage0First auto
Message property _SHWellBeingMessage1 auto
Message property _SHWellBeingMessage1First auto
Message property _SHWellBeingMessage2 auto
Message property _SHWellBeingMessage2First auto
Message property _SHWellBeingMessage3 auto
Message property _SHWellBeingMessage3First auto

Message property _SHWellBeingTut auto

int property _SHWellBeingStage0 auto
int property _SHWellBeingStage1 auto
int property _SHWellBeingStage2 auto
int property _SHWellBeingStage3 auto

bool ShowNewStageMessage
bool wasVeryHealthy = false

int hourCount = 0

int property CurrentStage auto hidden 
;Events
;Functions

Function StartWellBeing()  
    if(!IsRunning())
        _SHWellBeingTimeStamp.SetValue(Utility.GetCurrentGameTime())
        Start()
        Player = Game.GetPlayer()
        GetNewSystemStage()
        ApplyEffects()

        ;if(_SHMain.CampfireInstalled)
        ;    RegisterForUpdateGameTime(1.0)
        ;endif
    EndIf
EndFunction

Function StopWellBeing()
    if(IsRunning())
        RemoveEffects()
        Stop()
    EndIf
EndFunction

;No longer needed. Well Being is no longer coupled to your survival skill
Event OnUpdateGameTime()
	;int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHWellBeingTimeStamp.GetValue()) * 24)    

    ;if(CurrentStage == 0)      
        ;Increment skill for every hour passed

    ;    int index = 0
    ;    While (index < HoursPassed)
    ;        if(hourCount == 12)
    ;            hourCount = 0
    ;            _SHMain.AdvanceSurvivalSKill(true)
    ;        Else
    ;            hourCount=hourCount+1
    ;            _SHMain.AdvanceSurvivalSKill(false)
    ;        endif
    ;        index = index + 1
    ;    EndWhile    
    ;endif

    ;_SHWellBeingTimeStamp.SetValue(Utility.GetCurrentGameTime())
    ;RegisterForUpdateGameTime(1.0)
EndEvent

;Increase well being by number of points
Function IncreaseWellBeing(float value)
    
    _SHWellBeingLevel.SetValue(_SHWellBeingLevel.GetValue() + value)

    if(_SHWellBeingLevel.GetValue() > _SHWellBeingStage3)
        _SHWellBeingLevel.SetValue(50.00)
    endif

    GetNewSystemStage()
    ApplyEffects()
EndFunction

;Decrease well being by number of points
Function DecreaseWellBeing(float value)
    _SHWellBeingLevel.SetValue(_SHWellBeingLevel.GetValue() - value)

    if(_SHWellBeingLevel.GetValue() < 0.00)
        _SHWellBeingLevel.SetValue(0.00)
    endif

    GetNewSystemStage()
    ApplyEffects()
EndFunction

Function ApplyEffects()
    RemoveEffects()       ;Remove effects before applying new ones
    bool showMessage 
    If ((_SHMessagesEnabled.GetValue() == 1) && ShowNewStageMessage)
        showMessage = true
    Else
        showMessage = false
    EndIf

    if(CurrentStage == 0)
        If (showMessage)
            if(_SHMain.FirstPersonMessages)
                _SHWellBeingMessage0First.Show()
            else
                _SHWellBeingMessage0.Show()
            endif
        EndIf
        Player.AddSpell(_SHWellBeing0, false)
    ElseIf (CurrentStage == 1)
        If (showMessage)
            if(_SHMain.FirstPersonMessages)
                _SHWellBeingMessage1First.Show()
            else
                _SHWellBeingMessage1.Show()
            endif
        EndIf
        Player.AddSpell(_SHWellBeing1, false)
    ElseIf (CurrentStage == 2)
        If (showMessage)
            if(_SHMain.FirstPersonMessages)
                _SHWellBeingMessage2First.Show()
            else
                _SHWellBeingMessage2.Show()
            endif
        EndIf
        Player.AddSpell(_SHWellBeing2, false)
    ElseIf (CurrentStage == 3)
        If (showMessage)
            if(_SHMain.FirstPersonMessages)
                _SHWellBeingMessage3First.Show()
            else
                _SHWellBeingMessage3.Show()
            endif
        EndIf
        Player.AddSpell(_SHWellBeing3, false)
    EndIf
EndFunction

Function RemoveEffects()

    Player.RemoveSpell(_SHWellBeing0)
    Player.RemoveSpell(_SHWellBeing1)
    Player.RemoveSpell(_SHWellBeing2)
    Player.RemoveSpell(_SHWellBeing3)

EndFunction

;Set appropriate system stage level
Function GetNewSystemStage()

    int NewStage

    float currentLevel = _SHWellBeingLevel.GetValue()

    If (currentLevel < _SHWellBeingStage0)
        NewStage = 0

        if(!wasVeryHealthy)
            wasVeryHealthy = true
            _SHWellBeingTimeStamp.SetValue(Utility.GetCurrentGameTime())
        endif
    ElseIf (IsBetween(currentLevel, _SHWellBeingStage0, _SHWellBeingStage1))
        NewStage = 1
        wasVeryHealthy = false
    ElseIf (IsBetween(currentLevel, _SHWellBeingStage1, _SHWellBeingStage2))
        NewStage = 2
        wasVeryHealthy = false
    ElseIf (currentLevel >= _SHWellBeingStage3)
        NewStage = 3
        wasVeryHealthy = false
    EndIf

    If (NewStage != CurrentStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    if(NewStage == 2)
        If (_SHWellBeingTutEnabled.GetValue() == 1)
            _SHWellBeingTutEnabled.SetValue(0)
            _SHWellBeingTut.Show()
        EndIf
    endif

    CurrentStage = NewStage
EndFunction

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
