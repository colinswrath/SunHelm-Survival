Scriptname _SHHungerSystem extends _SHSystemBase

;Properties
Actor Player

;Hunger spells/Stages/Messages
int Property _SHHungerStage0 auto
int Property _SHHungerStage1 auto
int Property _SHHungerStage2 auto
int Property _SHHungerStage3 auto
int Property _SHHungerStage4 auto
int Property _SHHungerStage5 auto

int Property CurrentHungerStage auto hidden

Spell property _SHHungerSpell1 auto
Spell property _SHHungerSpell2 auto
Spell property _SHHungerSpell3 auto
Spell property _SHHungerSpell4 auto
Spell property _SHHungerSpell5 auto
Spell property _SHHungerSpell6 auto

Message property _SHHunger0 auto
Message property _SHHunger1 auto
Message property _SHHunger2 auto
Message property _SHHunger3 auto
Message property _SHHunger4 auto
Message property _SHHunger5 auto
Message property _SHHungerTut auto

Message property _SHHunger0First auto
Message property _SHHunger1First auto
Message property _SHHunger2First auto
Message property _SHHunger3First auto
Message property _SHHunger4First auto
Message property _SHHunger5First auto

Sound property _SHHungerSounds auto

GlobalVariable Property _SHHungerTutEnabled auto
bool ShowNewStageMessage
bool Increasing
bool startup
bool wasWellFed = false
;Events

;Functions

;Calls parent method to start the system
Function StartSystem()
    If (!IsRunning())
        _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
        parent.StartSystem()
        CurrentHungerStage = -1
        startUp = true
        Player = game.GetPlayer()
        GetNewSystemStage()
        ApplySystemEffects()
        startup = false
    EndIf
EndFunction

;Stops the system.
Function StopSystem()
    parent.StopSystem()
EndFunction

;Updates the need values
Function UpdateNeed()
    IncrementHungerLevel()
    GetNewSystemStage()
    ApplySystemEffects()
    _SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
EndFunction

;Apply the correct spell to the player based on the stage
Function ApplySystemEffects()
    Player = game.GetPlayer()

    if(ShowNewStageMessage)
        RemoveSystemEffects()       ;Remove effects before applying new ones
        bool showMessage 
        If ((_SHMessagesEnabled.GetValue() == 1))
            showMessage = true
        Else
            showMessage = false
        EndIf

        ;Decide which spell set to add
        If (CurrentHungerStage == 0)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger0First.Show()
                Else
                    _SHHunger0.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell1, false)
        ElseIf (CurrentHungerStage == 1)
            If (showMessage && (Increasing || startup))
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger1First.Show()
                Else
                    _SHHunger1.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell2, false)
        ElseIf (CurrentHungerStage == 2)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger2First.Show()
                Else
                    _SHHunger2.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell3, false)
        ElseIf (CurrentHungerStage == 3)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger3First.Show()
                Else
                    _SHHunger3.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell4, false)
        ElseIf (CurrentHungerStage == 4)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger4First.Show()
                Else
                    _SHHunger4.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell5, false)
        ElseIf (CurrentHungerStage == 5)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHHunger5First.Show()
                Else
                    _SHHunger5.Show()
                endif
            EndIf
            Player.AddSpell(_SHHungerSpell6, false)
        EndIf

        if(CurrentHungerStage > 1 && Increasing == true)
            ApplyFx()
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    Player = game.GetPlayer()

    ;Remove the spells from the player
    Player.RemoveSpell(_SHHungerSpell1)
    Player.RemoveSpell(_SHHungerSpell2)
    Player.RemoveSpell(_SHHungerSpell3)
    Player.RemoveSpell(_SHHungerSpell4)
    Player.RemoveSpell(_SHHungerSpell5)
    Player.RemoveSpell(_SHHungerSpell6)

EndFunction

Function ApplyFx()

    If (_SHMain.ToggleSounds)
        _SHHungerSounds.Play(Player)
    EndIf
EndFunction


;Set appropriate system stage level
Function GetNewSystemStage()

    int NewStage
    bool wellBeing = _SHMain.WellBeing.IsRunning()
    float currentLevel = _SHCurrentHungerLevel.GetValue()

    If (currentLevel < _SHHungerStage1)
        NewStage = 0
        if(!wasWellFed)
            wasWellFed = true
            if(wellBeing && !startup)
                _SHMain.AdvanceSurvivalSKill()
                if(_SHMain._SH_PerkRank_AbleBodied.GetValueInt() == 1)
                    _Well.DecreaseWellBeing(2.25)
                ElseIf (_SHMain._SH_PerkRank_AbleBodied.GetValueInt() == 2)
                    _Well.DecreaseWellBeing(3.0)
                else
                    _Well.DecreaseWellBeing(1.5)
                endif
            endif
        endif
    ElseIf (IsBetween(currentLevel, _SHHungerStage1, _SHHungerStage2))
        NewStage = 1
        wasWellFed = false
        _Well.DecreaseWellBeing(0.75)
    ElseIf (IsBetween(currentLevel, _SHHungerStage2, _SHHungerStage3))
        NewStage = 2
        wasWellFed = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(1.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHHungerStage3, _SHHungerStage4))
        NewStage = 3
        wasWellFed = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(2.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHHungerStage4, _SHHungerStage5))
        NewStage = 4
        wasWellFed = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(3.0)
        endif
    ElseIf (currentLevel >= _SHHungerStage5)
        NewStage = 5
        wasWellFed = false
        if(wellBeing && !startup)
            if(_SHMain._SH_PerkRank_Vigorous.GetValueInt() == 1)
                _Well.IncreaseWellBeing(3.0)
            else
                _Well.IncreaseWellBeing(6.0)
            endif
        endif
    EndIf

    If (NewStage != CurrentHungerStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    If (NewStage == 2)
        if(_SHHungerTutEnabled.GetValue() == 1)
            _SHHungerTutEnabled.SetValue(0)
            _SHHungerTut.Show()
        EndIf
    EndIf

    CurrentHungerStage = NewStage

EndFunction

Function IncrementHungerLevel()
    Increasing = true
    ;Calculates how much time has passed since the last update
    int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHHungerTimeStamp.GetValue()) * 24)  

    ;Damage when hungry
    If (_SHNeedsDeath.GetValue() == 1)
        if(CurrentHungerStage == 5)
           Game.GetPlayer().DamageActorValue("Health", (Utility.RandomInt(1,75))*HoursPassed)
        EndIf
    EndIf

	;Calculates the hunger/Thirst that has been accumulated 10% variability
    float incValue = _SHCurrentHungerLevel.GetValue() + (HoursPassed * (_SHHungerRate.GetValue()+ Utility.RandomFloat(-1.0,1.0)))

    If (_SHMain.CarriageTravelled)
        incValue = incValue / 2
    EndIf

    If(HungerWasSleeping)
        HungerWasSleeping = false
        incValue = incValue*0.75
    endif
    
    _SHCurrentHungerLevel.SetValue(incValue)

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentHungerLevel.GetValue() > _SHHungerStage5)
        _SHCurrentHungerLevel.SetValue(_SHHungerStage5)
    EndIf
EndFunction

;Decreases the hunger level by provided amount
Function DecreaseHungerLevel(float decAmount)

    _SHCurrentHungerLevel.SetValue(_SHCurrentHungerLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure hunger level doesn't go below value
    If (_SHCurrentHungerLevel.GetValue() < 0)
        _SHCurrentHungerLevel.SetValue(0)
    EndIf

    Increasing = false
    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true

    SendModEvent("_SH_UpdateWidget")
EndFunction

;Parent calls
Function PauseUpdates()
    parent.PauseUpdates()
EndFunction

Function ResumeUpdates()
    parent.ResumeUpdates()
EndFunction