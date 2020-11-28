Scriptname _SHThirstSystem extends _SHSystemBase


;Properties
Actor Player

int Property _SHThirstStage0 auto
int Property _SHThirstStage1 auto
int Property _SHThirstStage2 auto
int Property _SHThirstStage3 auto
int Property _SHThirstStage4 auto
int Property _SHThirstStage5 auto

int Property CurrentThirstStage auto hidden

Potion property _SHWaterBottleMead auto

Spell Property _SHThirstSpell1 Auto
Spell Property _SHThirstSpell2 Auto
Spell Property _SHThirstSpell3 Auto
Spell Property _SHThirstSpell4 Auto
Spell Property _SHThirstSpell5 Auto
Spell Property _SHThirstSpell6 Auto

Message property _SHThirstMessage0 auto
Message property _SHThirstMessage1 auto
Message property _SHThirstMessage2 auto
Message property _SHThirstMessage3 auto
Message property _SHThirstMessage4 auto
Message property _SHThirstMessage5 auto
Message property _SHThirstTut auto

Message property _SHThirstMessage0First auto
Message property _SHThirstMessage1First auto
Message property _SHThirstMessage2First auto
Message property _SHThirstMessage3First auto
Message property _SHThirstMessage4First auto
Message property _SHThirstMessage5First auto

Sound property _SHThirstSoundsF auto
Sound property _SHThirstSoundsM auto

GlobalVariable Property _SHThirstTutEnabled auto
GlobalVariable property _SHFirstTimeEnabled auto

bool ShowNewStageMessage
bool Increasing
bool startUp
bool wasQuenched = false

;Functions

;Calls parent method to start the system
Function StartSystem()
    If (!IsRunning())
        _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
        ;add water to player
        If (_SHFirstTimeEnabled.GetValue() == 1)
            game.GetPlayer().AddItem(_SHMain._SHWaterskin_3, 1)
        EndIf
        parent.StartSystem()
        CurrentThirstStage = -1
        startUp = true
        GetNewSystemStage()
        ApplySystemEffects()
        startUp = false
    EndIf

EndFunction

;Stops the system.
Function StopSystem()
    parent.StopSystem()
EndFunction

Function UpdateNeed()
    IncrementThirstLevel()
    GetNewSystemStage()
    ApplySystemEffects()
    _SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
    _SHMain.ResetDrinkCount()
EndFunction

Function GetNewSystemStage()
    int NewStage
    bool wellBeing = _SHMain.WellBeing.IsRunning()
    float currentLevel = _SHCurrentThirstLevel.GetValue()

    If (currentLevel < _SHThirstStage1)
        NewStage = 0
        
        if(!wasQuenched)
            wasQuenched = true
            if(wellBeing && !startUp)
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
    ElseIf (IsBetween(currentLevel, _SHThirstStage1, _SHThirstStage2))
        NewStage = 1
        wasQuenched = false
        _Well.DecreaseWellBeing(0.75)
    ElseIf (IsBetween(currentLevel, _SHThirstStage2, _SHThirstStage3))
        NewStage = 2
        wasQuenched = false
        if(wellBeing && !startUp)
            _Well.IncreaseWellBeing(1.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHThirstStage3, _SHThirstStage4))
        NewStage = 3
        wasQuenched = false
        if(wellBeing && !startUp)
            _Well.IncreaseWellBeing(2.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHThirstStage4, _SHThirstStage5))
        NewStage = 4
        wasQuenched = false
        if(wellBeing && !startUp)
            _Well.IncreaseWellBeing(3.0)
        endif
    ElseIf (currentLevel >= _SHThirstStage5)
        NewStage = 5
        wasQuenched = false
        if(wellBeing && !startUp)
            if(_SHMain._SH_PerkRank_Vigorous.GetValueInt() == 1)
                _Well.IncreaseWellBeing(3.0)
            else
                _Well.IncreaseWellBeing(6.0)
            endif
        endif
    EndIf

    If (NewStage != CurrentThirstStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf

    If (NewStage == 2)
        if(_SHThirstTutEnabled.GetValue() == 1)
            _SHThirstTutEnabled.SetValue(0)
            _SHThirstTut.Show()
        EndIf
    EndIf

    CurrentThirstStage = NewStage
EndFunction

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
        If (CurrentThirstStage == 0)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage0First.Show()
                Else
                    _SHThirstMessage0.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell1, false)
        ElseIf (CurrentThirstStage == 1)
            If (showMessage && (Increasing || startUp))
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage1First.Show()
                Else
                    _SHThirstMessage1.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell2, false)
        ElseIf (CurrentThirstStage == 2)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage2First.Show()
                Else
                    _SHThirstMessage2.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell3, false)
        ElseIf (CurrentThirstStage == 3)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage3First.Show()
                Else
                    _SHThirstMessage3.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell4, false)
        ElseIf (CurrentThirstStage == 4)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage4First.Show()
                Else
                    _SHThirstMessage4.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell5, false)
        ElseIf (CurrentThirstStage == 5)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHThirstMessage5First.Show()
                Else
                    _SHThirstMessage5.Show()
                endif
            EndIf
            Player.AddSpell(_SHThirstSpell6, false)
        EndIf

        if(CurrentThirstStage > 1 && Increasing == true)
            ApplyFx()
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    Player = game.GetPlayer()

    ;Remove the spells from the player
    Player.RemoveSpell(_SHThirstSpell1)
    Player.RemoveSpell(_SHThirstSpell2)
    Player.RemoveSpell(_SHThirstSpell3)
    Player.RemoveSpell(_SHThirstSpell4)
    Player.RemoveSpell(_SHThirstSpell5)
    Player.RemoveSpell(_SHThirstSpell6)

EndFunction

Function ApplyFx()

    If(_SHMain.ToggleSounds)
        If (_SHMain.SexMale)
            _SHThirstSoundsM.Play(Player)
        Else
            _SHThirstSoundsF.Play(Player)
        EndIf
    EndIf
EndFunction

Function IncrementThirstLevel()
    Increasing = true

    ;Calculates how much time has passed since the last update
    int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHThirstTimeStamp.GetValue()) * 24)  
    
    ;Damage when Thirsty
    If (_SHNeedsDeath.GetValue() == 1)
        if(CurrentThirstStage == 5)
           Game.GetPlayer().DamageActorValue("Health", (Utility.RandomInt(1,75))* HoursPassed)
        EndIf
    EndIf

    float incValue = (_SHCurrentThirstLevel.GetValue() + (HoursPassed * (_SHThirstRate.GetValue() + Utility.RandomFloat(-1.0,1.0))))

    ;Slower vampire rate
    if(_SHMain.Vampire && _SHMain.VampireThirst)
        incValue = incValue / 2
    Endif

    If (_SHMain.CarriageTravelled)
        incValue = incValue / 2
    EndIf

    If(ThirstWasSleeping)
        ThirstWasSleeping = false
        incValue = incValue*0.75
    endif

	;Calculates the hunger/Thirst that has been accumulated 10% variability
    _SHCurrentThirstLevel.SetValue(incValue)

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentThirstLevel.GetValue() > _SHThirstStage5)
        _SHCurrentThirstLevel.SetValue(_SHThirstStage5)
    EndIf
EndFunction

Function DecreaseThirstLevel(float decAmount)
    _SHCurrentThirstLevel.SetValue(_SHCurrentThirstLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure thirst level doesn't go below value
    If (_SHCurrentThirstLevel.GetValue() < 0)
        _SHCurrentThirstLevel.SetValue(0)
    EndIf

    Increasing = false
    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true
    SendModEvent("_SH_UpdateWidget")

EndFunction

;Increase level by set amount
Function IncreaseThirstLevel(float incAmount)
    _SHCurrentThirstLevel.SetValue(_SHCurrentThirstLevel.GetValue() + incAmount)    ;Decrement the level

    ;Ensure thirst level doesn't go above value
    If (_SHCurrentThirstLevel.GetValue() > _SHThirstStage5)
        _SHCurrentThirstLevel.SetValue(0)
    EndIf
    
    RemoveSystemEffects()   ;Remove again just to make sure
    GetNewSystemStage()
    ApplySystemEffects()

    SendModEvent("_SH_UpdateWidget")

EndFunction

;Parent calls
Function PauseUpdates()
    parent.PauseUpdates()
EndFunction

Function ResumeUpdates()
    parent.ResumeUpdates()
EndFunction