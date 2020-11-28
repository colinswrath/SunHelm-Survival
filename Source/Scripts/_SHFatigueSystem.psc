Scriptname _SHFatigueSystem extends _SHSystemBase

;Properties
Actor Player

int Property _SHFatigueStage0 auto
int Property _SHFatigueStage1 auto
int Property _SHFatigueStage2 auto
int Property _SHFatigueStage3 auto
int Property _SHFatigueStage4 auto
int Property _SHFatigueStage5 auto

keyword property LocTypePlayerHouse auto

int Property CurrentFatigueStage auto hidden
int Property OldFatigueStage auto hidden

float Property SleepStartTime auto hidden
float Property SleepStopTime auto hidden

Spell property _SHFatigueSpell1 auto
Spell property _SHFatigueSpell2 auto
Spell property _SHFatigueSpell3 auto
Spell property _SHFatigueSpell4 auto
Spell property _SHFatigueSpell5 auto
Spell property _SHFatigueSpell6 auto

spell property WellRested auto
spell property Rested auto

Message property _SHFatigue0 auto
Message property _SHFatigue1 auto
Message property _SHFatigue2 auto
Message property _SHFatigue3 auto
Message property _SHFatigue4 auto
Message property _SHFatigue5 auto
Message property _SHFatigueTut auto

Message property _SHFatigue0First auto
Message property _SHFatigue1First auto
Message property _SHFatigue2First auto
Message property _SHFatigue3First auto
Message property _SHFatigue4First auto
Message property _SHFatigue5First auto

Sound property _SHFatigueSoundsF auto
Sound property _SHFatigueSoundsM auto

quest property PlayerSleepQuest auto
quest property RelationshipMarriageFIN auto
quest property BYOHRelationshipAdoption auto
referencealias property LoveInterest auto
spell property MarriageRested auto
locationalias property CurrentHomeLocation auto
message property BYOHAdoptionRestedMessageMale auto
message property BYOHAdoptionRestedMessageFemale auto
spell property BYOHAdoptionSleepAbilityMale auto
spell property BYOHAdoptionSleepAbilityFemale auto
message property MarriageRestedMessage auto

GlobalVariable Property _SHFatigueTutEnabled auto
bool ShowNewStageMessage
bool Increasing
bool startup
bool wasWellRested = false

;Events

;Detect when the player starts sleeping
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
    SleepStartTime = afSleepStartTime
    _SHWasSleeping = true
    HungerWasSleeping = true
    ThirstWasSleeping = true
EndEvent

;Detect when the player stops sleeping
Event OnSleepStop(bool abInterrupted)
    ;_SHWasSleeping = true   ;Failsafe might have been causing the issue
    SleepStopTime = Utility.GetCurrentGameTime()  

    float decrease = GetSleepDecreaseAmount()
    ;If sleeping in a bedroll
    if(_SHMain.BedrollSleep)
        decrease = decrease * 0.75 
        if(_SHMain.FirstPersonMessages)
            _SHMain._SHBedrollFirst.Show()
        else
            _SHMain._SHBedroll.Show()
        endif
        _SHMain.BedrollSleep = false
    endif
    DecreaseFatigueLevel(decrease)
    
EndEvent
;Functions

;Start up the Fatigue system
Function StartSystem()
    If (!IsRunning())       
        _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
        parent.StartSystem()
        CurrentFatigueStage = -1
        StopVanillaSleep()
        startup = true
        RegisterForSleep()
        GetNewSystemStage()
        ApplySystemEffects()
        startup = false
    EndIf
EndFunction

Function StopVanillaSleep()
    PlayerSleepQuest.UnregisterForSleep()
    Player.RemoveSpell(Rested)
    Player.RemoveSpell(WellRested)
    Player.RemoveSpell(BYOHAdoptionSleepAbilityMale)
    Player.RemoveSpell(BYOHAdoptionSleepAbilityFemale)
EndFunction

Function ApplySpouseAdoptionBonuses()

    location currentLocation = Player.GetCurrentLocation()
	if RelationshipMarriageFIN.IsRunning() && RelationshipMarriageFIN.GetStage() >= 10 && currentLocation == LoveInterest.GetActorRef().GetCurrentLocation()
        Player.RemoveSpell(MarriageRested)
        MarriageRestedMessage.Show()
		Player.AddSpell(MarriageRested, false)
    endIf

    if BYOHRelationshipAdoption.IsRunning() && Player.GetCurrentLocation() == CurrentHomeLocation.GetLocation()
        Player.RemoveSpell(BYOHAdoptionSleepAbilityMale)
        Player.RemoveSpell(BYOHAdoptionSleepAbilityFemale)
		if Player.GetActorBase().GetSex() == 0
			BYOHAdoptionRestedMessageMale.Show()
			Player.AddSpell(BYOHAdoptionSleepAbilityMale, false)
		else
			BYOHAdoptionRestedMessageFemale.Show()
			Player.AddSpell(BYOHAdoptionSleepAbilityFemale, false)
		endIf
	endIf
    
EndFunction

;Stop the fatigue system
Function StopSystem()
    PlayerSleepQuest.RegisterForSleep()
    parent.StopSystem()
EndFunction

;Updates the need values
Function UpdateNeed()
    if(!_SHWasSleeping)
        IncrementFatigueLevel()
        GetNewSystemStage()
        ApplySystemEffects()
    Else
        _SHWasSleeping = false  ;Reset sleep variable
    EndIf
    _SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
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
        If (CurrentFatigueStage == 0)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue0First.Show()
                Else
                    _SHFatigue0.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell1, false)
        ElseIf (CurrentFatigueStage == 1)
            If (showMessage && (Increasing || startup))
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue1First.Show()
                Else
                    _SHFatigue1.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell2, false)
        ElseIf (CurrentFatigueStage == 2)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue2First.Show()
                Else
                    _SHFatigue2.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell3, false)
        ElseIf (CurrentFatigueStage == 3)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue3First.Show()
                Else
                    _SHFatigue3.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell4, false)
        ElseIf (CurrentFatigueStage == 4)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue4First.Show()
                Else
                    _SHFatigue4.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell5, false)
        ElseIf (CurrentFatigueStage == 5)
            If (showMessage)
                if(_SHMain.FirstPersonMessages)              
                    _SHFatigue5First.Show()
                Else
                    _SHFatigue5.Show()
                endif
            EndIf
            Player.AddSpell(_SHFatigueSpell6, false)
        EndIf

        if(CurrentFatigueStage > 1 && Increasing == true)
            ApplyFx()
        EndIf
    endif
EndFunction

;Remove the system effects
Function RemoveSystemEffects()
    Player = game.GetPlayer()

    ;Remove the spells from the player
    Player.RemoveSpell(_SHFatigueSpell1)
    Player.RemoveSpell(_SHFatigueSpell2)
    Player.RemoveSpell(_SHFatigueSpell3)
    Player.RemoveSpell(_SHFatigueSpell4)
    Player.RemoveSpell(_SHFatigueSpell5)
    Player.RemoveSpell(_SHFatigueSpell6)
EndFunction

;Return appropriate system stage level
Function GetNewSystemStage()
    
    int NewStage
    bool wellBeing = _SHMain.WellBeing.IsRunning()
    float currentLevel = _SHCurrentFatigueLevel.GetValue()

    If (currentLevel < _SHFatigueStage1)
        NewStage = 0
        if(!wasWellRested)
            wasWellRested = true
            ApplySpouseAdoptionBonuses()
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
    ElseIf (IsBetween(currentLevel, _SHFatigueStage1, _SHFatigueStage2))
        NewStage = 1
        wasWellRested = false
        _Well.DecreaseWellBeing(0.75)
    ElseIf (IsBetween(currentLevel, _SHFatigueStage2, _SHFatigueStage3))
        NewStage = 2
        wasWellRested = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(1.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHFatigueStage3, _SHFatigueStage4))
        NewStage = 3
        wasWellRested = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(2.0)
        endif
    ElseIf (IsBetween(currentLevel, _SHFatigueStage4, _SHFatigueStage5))
        NewStage = 4
        wasWellRested = false
        if(wellBeing && !startup)
            _Well.IncreaseWellBeing(3.0)
        endif
    ElseIf (currentLevel >= _SHFatigueStage5)
        NewStage = 5
        wasWellRested = false
        if(wellBeing && !startup)
            if(_SHMain._SH_PerkRank_Vigorous.GetValueInt() == 1)
                _Well.IncreaseWellBeing(3.0)
            else
                _Well.IncreaseWellBeing(6.0)
            endif
        endif
    EndIf

    If (NewStage != CurrentFatigueStage)
        ShowNewStageMessage = true
    Else
        ShowNewStageMessage = false
    EndIf
    
    If(NewStage == 2)
        if(_SHFatigueTutEnabled.GetValue() == 1)
            _SHFatigueTutEnabled.SetValue(0)
            _SHFatigueTut.Show()
        EndIf
    EndIf

    CurrentFatigueStage = NewStage
EndFunction

Function ApplyFx()
    If(_SHMain.ToggleSounds)
        If (_SHMain.SexMale)
            _SHFatigueSoundsM.Play(Player)
        Else
            _SHFatigueSoundsF.Play(Player)
        EndIf
    EndIf
EndFunction

;Increases the fatigue level by provided amount
Function IncrementFatigueLevel()
    Increasing = true
    
    ;Calculates how much time has passed since the last update
	int HoursPassed = Round((Utility.GetCurrentGameTime() - _SHFatigueTimeStamp.GetValue()) * 24)    
    
	;Calculates the hunger/Thirst that has been accumulated
    float incValue = _SHCurrentFatigueLevel.GetValue() + (HoursPassed * (_SHFatigueRate.GetValue()+ Utility.RandomFloat(-1.0,1.0)))

    if(_SHMain.CarriageTravelled)
        incValue = incValue / 2
    endif

    _SHCurrentFatigueLevel.SetValue(incValue)

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentFatigueLevel.GetValue() > _SHFatigueStage5)
        _SHCurrentFatigueLevel.SetValue(_SHFatigueStage5)
    EndIf
EndFunction

;Find out how much to decrease fatigue (testing needed)
float Function GetSleepDecreaseAmount()

    ;Failsafe for the event that this somehow gets called before OnSleepStop
    if(!SleepStopTime)
        SleepStopTime = Utility.GetCurrentGameTime()
    endif

    float hoursPassed = Round((SleepStopTime - SleepStartTime) * 24)
    return (hoursPassed * (25.00))
EndFunction

;Decreases the fatigue level by provided amount
Function DecreaseFatigueLevel(float decAmount)

    _SHCurrentFatigueLevel.SetValue(_SHCurrentFatigueLevel.GetValue() - decAmount)    ;Decrement the level
    ;Ensure hunger level doesn't go below value
    If (_SHCurrentFatigueLevel.GetValue() < 0.0)
        _SHCurrentFatigueLevel.SetValue(0.0)
    EndIf

    Increasing = false
    GetNewSystemStage()
    ApplySystemEffects()
    Increasing = true
    SendModEvent("_SH_UpdateWidget")
EndFunction

;Set the fatigue level to provided value
Function SetFatigueLevel(float amount)

    _SHCurrentFatigueLevel.SetValue(amount)    ;Decrement the level

    If (_SHCurrentFatigueLevel.GetValue() < 0)
        _SHCurrentFatigueLevel.SetValue(0)
    EndIf

    ;We dont want to go greater than the greatest possible
    if(_SHCurrentFatigueLevel.GetValue() > _SHFatigueStage5)
        _SHCurrentFatigueLevel.SetValue(_SHFatigueStage5)
    EndIf

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