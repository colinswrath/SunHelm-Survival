Scriptname _SH_MCMScript extends SKI_ConfigBase

_SunHelmMain property _SHMain auto
_SHWidgetScript property _SHWidget auto

GlobalVariable Property _SHMessagesEnabled auto
GlobalVariable Property _SHNeedsDeath auto
GlobalVariable Property _SHDisableFT auto
GlobalVariable Property _SHEnabled Auto
GlobalVariable property _SHCannibalism auto
GlobalVariable property _SHDrunkSkoomaFX auto

GlobalVariable Property _SHHungerTutEnabled auto
GlobalVariable Property _SHThirstTutEnabled auto
GlobalVariable Property _SHFatigueTutEnabled auto
GlobalVariable property _SHWellBeingTutEnabled auto

int WidgetXNoOffset = 1175
int WidgetYNoOffset = 721

;---------------------------
;TOGGLE STATES
;-----------------------------
;General
bool ToggleTravelDisableVal = true
bool ToggleAnimsVal = true
bool ToggleRefillVal = true
bool ToggleFatigueVal = true
bool ToggleThirstVal = true
bool ToggleHungerVal = true

bool ToggleCannibalVal = false
bool ToggleRawDamageVal = true
bool ToggleWerewolfFatigueVal = true
bool ToggleWerewolfPauseVal = true
bool ToggleVampireThirstVal = true
bool ToggleCarryWeightPenVal = true
bool ToggleArrowWeightSleepVal = true
bool TogglePauseOblivionVal = true
bool ToggleEquipWaterskinVal = true
bool ToggleBottlesVal = true

bool ToggleDiseasesVal = true


;Display
Bool ToggleMessagesVal = True
bool ToggleTutsVal = true
bool ToggleSoundsVal = true
bool ToggleWidgetsVal = true
bool ToggleFirstPersonVal = true
bool ToggleDetailedContinuanceVal = true
int WidgetXVal
int WidgetYVal

;Needs
bool ToggleOblivionVal = False
bool ToggleDeathVal = true
bool ToggleCombatVal = true
bool ToggleDrunkFxVal = true
int AlcoholDrinksVal
;Help

;----------------------------
;Option IDs
;---------------------------
;General
int ToggleMod
int ToggleTravelDisable
int ToggleAnims
int ToggleRefill
int ToggleFatigue
int ToggleThirst
int ToggleHunger
int ToggleCannibal
int ToggleRawDamage
int WerewolfFill
int ToggleWerewolfFatigue
int ToggleWerewolfPause
int VampireOptions
int VampireThirst
int ToggleCarryWeightPen
int ToggleArrowOption
int ResetFormListsOption
int TogglePauseOblivion
int ToggleEquipWaterskin
int WaterskinLocationOption
int ToggleBottles
int DrinkAndFillHotkeyOption
Int DrinkAndFillHotkey = -1
int ContinuanceHotkeyOption
int ContinuanceHotkey = -1
int ToggleDisablePowers
int ToggleDiseases

;Display
int ToggleMessages
int ToggleTuts
int ToggleSounds
int ToggleWidgets
int WidgetOrientation
int WidgetDisplayType
int WidgetXOption
int WidgetYOption
int WidgetPreset
int HungerRateOption
int ThirstRateOption
int FatigueRateOption
int ToggleFirstPerson
int WidgetHotKey
int ToggleDetailedContinuance

;Needs

int ToggleDeath
int ToggleDrunkFx
int AlcoholDrinksOption

;Survival Skill Tree
int SurvivalRespec
int SurvivalRestore
int SurvivalSkillRestoreSlider

;Help
int NeedsHelp
int HungerHelp
int FatigueHelp
int ThirstHelp
int RefillHelp
int WerewolfHelp
int VampireHelp
int ArrowHelp


;--------------------------
;Strings
;-------------------------
String[] ModToggleArray
String[] OrientationArray
String[] WidgetDisplayArray
String[] WidgetPresetArray
String[] WerewolfFillArray
String[] VampireOptionArray
String[] WaterskinArray

;---------------------------
;Indexes
;--------------------------
int IndexToggleMod
int IndexOrientation
int IndexWidgetDisplay
int IndexWidgetPreset
int IndexWerewolfFill
int IndexVampire
int IndexWaterskin


;Help
;---------------------------
;Events
;---------------------------
int Function GetVersion()
    return 4
endfunction

;On the MCM load
Event OnConfigInit()
    Pages = new string[5]
    Pages[0] = "$GeneralSettings"
    Pages[1] = "$DisplaySettings"
    Pages[2] = "$Needs"
    Pages[3] = "$SkillTree"
    Pages[4] = "$Help"

    ModToggleArray = new String[2]
    ModToggleArray[0] = "$Disabled"
    ModToggleArray[1] = "$Enabled"

    OrientationArray = new String[2]
    OrientationArray[0] = "$Vertical"
    OrientationArray[1] = "$Horizontal"

    WidgetDisplayArray = new String[3]
    WidgetDisplayArray[0] = "$Alpha"
    WidgetDisplayArray[1] = "$Color"
    WidgetDisplayArray[2] = "$AlphaColor"

    WidgetPresetArray = new String[4]
    WidgetPresetArray[0] = "$Top_Left"
    WidgetPresetArray[1] = "$Top_Right"
    WidgetPresetArray[2] = "$Bottom_Left"
    WidgetPresetArray[3] = "$Bottom_Right"

    IndexWidgetPreset = 3

    WerewolfFillArray = new String[3]
    WerewolfFillArray[0] = "$Hunger_Thirst"
    WerewolfFillArray[1] = "$Hunger"
    WerewolfFillArray[2] = "$Thirst"

    VampireOptionArray = new String[3]
    VampireOptionArray[0] = "$Thirst"
    VampireOptionArray[1] = "$Fatigue_Thirst"
    VampireOptionArray[2] = "$Mortal"

    WaterskinArray = new String[3]
    WaterskinArray[0] = "$Back"
    WaterskinArray[1] = "$Right"
    WaterskinArray[2] = "$Left"
EndEvent

;Is triggered on MCM menu update
Event OnVersionUpdate(int a_version)
    if (a_version > 1)
        Debug.Trace(self + "$UpdatingToVersion" + a_version)
		OnConfigInit()
    endif
EndEvent

Event OnConfigOpen()
    IndexToggleMod = _SHEnabled.GetValueInt()
    IndexOrientation = _SHMain.Orientation
    ToggleWidgetsVal = !_SHMain.HideWidgets
    IndexWidgetDisplay = _SHMain.DisplayType
    IndexWaterskin = _SHMain.WaterskinLocation
    ToggleFirstPersonVal = _SHMain.FirstPersonMessages
    ToggleBottlesVal = _SHMain.Bottles
    ToggleFatigueVal = _SHMain.Fatigue.IsRunning()
    ToggleHungerVal = _SHMain.Hunger.IsRunning()
    ToggleThirstVal = _SHMain.Thirst.IsRunning()
    ToggleCannibalVal = _SHCannibalism.GetValue()
    ToggleDetailedContinuanceVal = _SHMain.ToggleDetailedContin
    ToggleDiseasesVal = _SHMain._SHDiseasesEnabled.GetValue()
    

    IndexWerewolfFill = _SHMain.WerewolfFeedOptions - 1
    IndexVampire = _SHMain.VampireNeedsOption - 1


    ;Set tutorials to false if matches
    if(_SHHungerTutEnabled.GetValue() == 0 && _SHFatigueTutEnabled.GetValue() == 0 && _SHThirstTutEnabled.GetValue() == 0)
        ToggleTutsVal = false
    EndIf

EndEvent

;When a page is opened or reset
Event OnPageReset(string page)

    If(page == "")
        LoadCustomContent("SunHelmLogo.dds")
        return
    Else
        UnloadCustomContent()
    EndIf

    If(page == "$GeneralSettings")
        SetCursorFillMode(TOP_TO_BOTTOM)
        ;AddEmptyOption()
        
        if Game.IsFightingControlsEnabled()
            ToggleMod = AddMenuOption("$SunHelmSurvival", ModToggleArray[IndexToggleMod])
        else
            ToggleMod = AddMenuOption("$SunHelmSurvival", ModToggleArray[IndexToggleMod], OPTION_FLAG_DISABLED)
            AddHeaderOption("$SHBoundHands",OPTION_FLAG_DISABLED)
        endif
        AddEmptyOption()

        if(_SHEnabled.GetValue() == 1)
            
            AddHeaderOption("$AnimOptions")
            ToggleAnims = AddToggleOption("$PlayEatDrinkAnims", ToggleAnimsVal)
            ToggleRefill = AddToggleOption("$PlayRefillAnims", ToggleRefillVal)
            AddEmptyOption()

            AddHeaderOption("$GameplayOptions")

            if(!_SHMain.ModComp.FrostfallInstalled)
                ToggleTravelDisable = AddToggleOption("$ToggleFT", ToggleTravelDisableVal) ;Unchecked means its off
            Else
                AddHeaderOption("$FrostfallMenu", OPTION_FLAG_DISABLED)
                ToggleTravelDisable = AddToggleOption("$ToggleFT", ToggleTravelDisableVal,OPTION_FLAG_DISABLED)
            endif
            ToggleCannibal = AddToggleOption("$ToggleCannibal",ToggleCannibalVal)

            ToggleRawDamage = AddToggleOption("$ToggleRaw",ToggleRawDamageVal)
            ToggleCarryWeightPen = AddToggleOption("$ToggleCW", ToggleCarryWeightPenVal)

            SetCursorPosition(1)

            ToggleArrowOption = AddToggleOption("$ArrowWeight", ToggleArrowWeightSleepVal)
            ResetFormListsOption = AddTextOption("$ResetFormLists","")
            ToggleBottles = AddToggleOption("$ToggleBottle", ToggleBottlesVal)
            ToggleDiseases = AddToggleOption("$ToggleDiseases",ToggleDiseasesVal)

            AddHeaderOption("$WaterskinOptions")
            ToggleEquipWaterskin = AddToggleOption("$WaterskinEquip", ToggleEquipWaterskinVal)
            WaterskinLocationOption = AddMenuOption("$WaterskinLocation", WaterskinArray[IndexWaterskin])

            ;Hotkeys
            AddHeaderOption("$Hotkeys")
            DrinkAndFillHotkeyOption = AddKeyMapOption("$DrinkAndFillHk", DrinkAndFillHotkey, OPTION_FLAG_WITH_UNMAP)
            ToggleDisablePowers = AddTextOption("$TogglePowers","")
            
        EndIf

    ElseIf(page == "$DisplaySettings")
        SetCursorFillMode(TOP_TO_BOTTOM)

        if(_SHEnabled.GetValue() == 1)
            AddHeaderOption("$DisplayOptions")
            ToggleTuts = AddToggleOption("Enable Tutorials", ToggleTutsVal)
            AddEmptyOption()
            AddHeaderOption("$Notifications")
            ToggleMessages = AddToggleOption("$DispMsgNotifs",ToggleMessagesVal)
            ToggleSounds = AddToggleOption("$SoundNotifs",ToggleSoundsVal)
            ToggleFirstPerson = AddToggleOption("$ToggleFirst", ToggleFirstPersonVal)
            AddEmptyOption()

            SetCursorPosition(1)

            AddHeaderOption("$WidgetOptions")
            ToggleWidgets = AddToggleOption("$ToggleWidget", ToggleWidgetsVal)
            WidgetOrientation = AddMenuOption("$WidgetOrient",OrientationArray[IndexOrientation])
            WidgetDisplayType = AddMenuOption("$WidgDisType",WidgetDisplayArray[IndexWidgetDisplay])
            AddEmptyOption()
        
            AddHeaderOption("$WidgetLocation")
            WidgetPreset = AddMenuOption("$PresetLoc",WidgetPresetArray[IndexWidgetPreset])
            WidgetXOption = AddSliderOption("$WidgXOff", WidgetXVal)
            WidgetYOption = AddSliderOption("$WidgYOff", WidgetYVal)

            AddHeaderOption("$ContinuanceOptions")

            ContinuanceHotkeyOption = AddKeyMapOption("$ContinuanceHk", ContinuanceHotkey, OPTION_FLAG_WITH_UNMAP)
            ToggleDetailedContinuance = AddToggleOption("$DetailedCont", ToggleDetailedContinuanceVal)
        Else
            AddHeaderOption("$EnableToView",OPTION_FLAG_DISABLED)
        EndIf

    ElseIf (page == "$Needs")
        SetCursorFillMode(TOP_TO_BOTTOM)

        if(_SHEnabled.GetValue() == 1)
            AddHeaderOption("$NeedsOptions")
            ToggleDeath = AddToggleOption("$DmgHungThirst", ToggleDeathVal)
            TogglePauseOblivion = AddToggleOption("$PauseOblivion", TogglePauseOblivionVal)

            AddHeaderOption("$Hunger")
            ToggleHunger = AddToggleOption("$ToggleHunger", ToggleHungerVal) 
            HungerRateOption = AddSliderOption("$HungerRate", _SHMain.Hunger._SHHungerRate.GetValue())

            AddHeaderOption("$Thirst")
            ToggleThirst = AddToggleOption("$ToggleThirst", ToggleThirstVal) 
            ThirstRateOption = AddSliderOption("$ThirstRate", _SHMain.Thirst._SHThirstRate.GetValue())

            AddHeaderOption("$Fatigue")
            ToggleFatigue = AddToggleOption("$ToggleFatigue", ToggleFatigueVal)
            FatigueRateOption = AddSliderOption("$FatigueRate", _SHMain.Fatigue._SHFatigueRate.GetValue())

            SetCursorPosition(1)

            AddHeaderOption("$AlcoholSkoomaOptions")

            ToggleDrunkFx = AddToggleOption("$DrunkSkoomaFx", ToggleDrunkFxVal)
            AlcoholDrinksOption = AddSliderOption("$AlcoholNumber", _SHMain._SHNumDrinks)

            AddHeaderOption("$WerewolfOptions")
            WerewolfFill = AddMenuOption("$WereFills", WerewolfFillArray[IndexWerewolfFill])
            ToggleWerewolfFatigue = AddToggleOption("$WerewolfFatigue", ToggleWerewolfFatigueVal)
            ToggleWerewolfPause = AddToggleOption("$WerewolfPause", ToggleWerewolfPauseVal)

            AddEmptyOption()
            AddHeaderOption("$VampireOptions")
            VampireOptions = AddMenuOption("$VampireNeeds", VampireOptionArray[IndexVampire])
            VampireThirst = AddToggleOption("$SlowerThirst", ToggleVampireThirstVal)



        Else
            AddHeaderOption("$EnableToView",OPTION_FLAG_DISABLED) 
        EndIf

    ElseIf(page == "$SkillTree")
        SetCursorFillMode(TOP_TO_BOTTOM)
        
        if(_SHEnabled.GetValue() == 1)
            AddHeaderOption("$SurvRespec")

            SurvivalRespec = AddTextOption("$RespecSkillPoints", "")
            SurvivalRestore = AddToggleOption("$RestSkillProg", false)
            SurvivalSkillRestoreSlider = AddSliderOption("$PointsToRestore", 0, "{0}", OPTION_FLAG_DISABLED)
        Else
            AddHeaderOption("$EnableToView",OPTION_FLAG_DISABLED)
        endif

    ElseIf(page == "$Help")
        SetCursorFillMode(TOP_TO_BOTTOM)
        

        if(_SHEnabled.GetValue() == 1)
            NeedsHelp = AddTextOption("$NeedsHelp", "")
            HungerHelp = AddTextOption("$HungerHelp", "")
            ThirstHelp = AddTextOption("$ThirstHelp", "")
            FatigueHelp = AddTextOption("$FatigueHelp", "")
            RefillHelp = AddTextOption("$RefillHelp", "")
            WerewolfHelp = AddTextOption("$WerewolfHelp", "")
            VampireHelp = AddTextOption("$VampireHelp", "")
            ArrowHelp = AddTextOption("$ArrowWeight", "")
        Else
            AddHeaderOption("$EnableToView",OPTION_FLAG_DISABLED)
        endif
    EndIf
    ;PAGE CONTENT
EndEvent


Event OnOptionSliderOpen(int Option)

    if(Option == WidgetXOption)
        SetSliderDialogStartValue(WidgetXVal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-500.0, 500.0)
        SetSliderDialogInterval(1.0)
    ElseIf (Option == WidgetYOption)
        SetSliderDialogStartValue(WidgetYVal)
		SetSliderDialogDefaultValue(0)
		SetSliderDialogRange(-740.0, 740)
        SetSliderDialogInterval(1.0)
    ElseIf (Option == HungerRateOption)
        SetSliderDialogStartValue(_SHMain.Hunger._SHHungerRate.GetValue())
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
    ElseIf (Option == ThirstRateOption)
        SetSliderDialogStartValue(_SHMain.Thirst._SHThirstRate.GetValue())
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
    ElseIf (Option == FatigueRateOption)
        SetSliderDialogStartValue(_SHMain.Fatigue._SHFatigueRate.GetValue())
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1.0)
    ElseIf (option == SurvivalSkillRestoreSlider)
        SetSliderDialogStartValue(0.0)
        SetSliderDialogDefaultValue(0.0)
        SetSliderDialogRange(0, _SHMain._SHPerkPointsTotal.GetValue())
        SetSliderDialogInterval(1.0)
    ElseIf (option == AlcoholDrinksOption)
        SetSliderDialogStartValue(_SHMain._SHNumDrinks)
        SetSliderDialogDefaultValue(3.0)
        SetSliderDialogRange(0, 10)
        SetSliderDialogInterval(1.0)  
    EndIf
EndEvent

Event OnOptionSliderAccept(Int Option, Float Value)
    If Option == WidgetXOption
		WidgetXVal = Value as Int
		SetSliderOptionValue(WidgetXOption, WidgetXVal)
        _SHMain.WidgetX = WidgetXNoOffset + WidgetXVal 
        ForcePageReset()
    
    ElseIf (Option == WidgetYOption)
        WidgetYVal = Value as Int
        SetSliderOptionValue(WidgetYOption, WidgetYVal)
        _SHMain.WidgetY = WidgetYNoOffset + WidgetYVal
        ForcePageReset()

    ElseIf (Option == HungerRateOption)
        _SHMain.Hunger._SHHungerRate.SetValue(Value as int)
        ForcePageReset()

    ElseIf (Option == ThirstRateOption)
        _SHMain.Thirst._SHThirstRate.SetValue(Value as int)
        ForcePageReset()

    ElseIf (Option == FatigueRateOption)
        _SHMain.Fatigue._SHFatigueRate.SetValue(Value as int)
        ForcePageReset()

    ElseIf (Option == SurvivalSkillRestoreSlider)
        _SHMain._SHPerkPointsProgress.SetValue(0.0)
        _SHMain._SHPerkPoints.SetValue(value)
        _SHMain._SHPerkPointsEarned.SetValue(value)
        ClearSurvivalPerks()
        ShowMessage("$SkillPtsRestored", false)
        SetOptionFlags(SurvivalSkillRestoreSlider, OPTION_FLAG_DISABLED, true)
        SetToggleOptionValue(SurvivalRestore, false)
    ElseIf (option == AlcoholDrinksOption)
        _SHMain._SHNumDrinks = Value as int
        ForcePageReset()
    EndIf

EndEvent

Event OnOptionKeyMapChange(Int Option, Int KeyCode, String ConflictControl, String ConflictName)

    if(Option == DrinkAndFillHotkeyOption)
        UnregisterForKey(DrinkAndFillHotkey)
		DrinkAndFillHotkey = KeyCode
        SetKeyMapOptionValue(DrinkAndFillHotkeyOption, DrinkAndFillHotkey, OPTION_FLAG_WITH_UNMAP)
    ElseIf (Option == ContinuanceHotkeyOption)
        UnregisterForKey(ContinuanceHotkey)
		ContinuanceHotkey = KeyCode
        SetKeyMapOptionValue(ContinuanceHotkeyOption, ContinuanceHotkey, OPTION_FLAG_WITH_UNMAP)
    endif
    ForcePageReset()
EndEvent


Event OnOptionSelect(int option)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;              GENERAL PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    If (CurrentPage == "$GeneralSettings")

        ;Toggle fast travel
        if(option == ToggleTravelDisable)
            ToggleTravelDisableVal = !ToggleTravelDisableVal
            SetToggleOptionValue(ToggleTravelDisable, ToggleTravelDisableVal)

            if(ToggleTravelDisableVal)
                Game.EnableFastTravel(False)
                _SHDisableFT.SetValue(1)
            Else
                Game.EnableFastTravel(True)
                _SHDisableFT.SetValue(0)
            EndIf

        EndIf

        ;Toggle Eat/Drink Animations
        if(option == ToggleAnims)
            ToggleAnimsVal = !ToggleAnimsVal
            SetToggleOptionValue(ToggleAnims,ToggleAnimsVal)

            If (ToggleAnimsVal)
                _SHMain.AnimationsEnabled = True
            Else
                _SHMain.AnimationsEnabled = false
            EndIf
        EndIf

        ;Toggle Refill Animations
        if(option == ToggleRefill)
            ToggleRefillVal = !ToggleRefillVal
            SetToggleOptionValue(ToggleRefill,ToggleRefillVal)

            If (ToggleRefillVal)
                _SHMain.RefillAnims = True
            Else
                _SHMain.RefillAnims = false
            EndIf
        EndIf

        if(option == ToggleCannibal)
            ToggleCannibalVal = !ToggleCannibalVal
            SetToggleOptionValue(ToggleCannibal,ToggleCannibalVal)

            if (ToggleCannibalVal)
                _SHCannibalism.SetValue(1)
                _SHMain.MCMCannibal = true
            else
                _SHCannibalism.SetValue(0)
                _SHMain.MCMCannibal = false
            EndIf
        EndIf

        if(option == ToggleRawDamage)
            ToggleRawDamageVal = !ToggleRawDamageVal
            SetToggleOptionValue(ToggleRawDamage, ToggleRawDamageVal)

            if(ToggleRawDamageVal)
                _SHMain._SHRawDamage.SetValue(1)
            else
                _SHMain._SHRawDamage.SetValue(0)
            EndIf
        EndIf

        If (option == ToggleCarryWeightPen)
            ToggleCarryWeightPenVal = !ToggleCarryWeightPenVal
            SetToggleOptionValue(ToggleCarryWeightPen, ToggleCarryWeightPenVal)

            If (ToggleCarryWeightPenVal)
                _SHMain._SHCarryWeight.SetValue(1)
            Else
                _SHMain._SHCarryWeight.SetValue(0)
            EndIf
        EndIf

        if(option == ToggleArrowOption)
            ToggleArrowWeightSleepVal = !ToggleArrowWeightSleepVal
            SetToggleOptionValue(ToggleArrowOption, ToggleArrowWeightSleepVal)

            if(ToggleArrowWeightSleepVal)
                _SHMain._SHEnableArrowSleep.SetValue(1)
                _SHMain.ExpectedSurvival = true
            Else
                _SHMain._SHEnableArrowSleep.SetValue(0)
                _SHMain.ExpectedSurvival = false
            endif
        endif

        if(option == ToggleBottles)
            ToggleBottlesVal = !ToggleBottlesVal
            SetToggleOptionValue(ToggleBottles, ToggleBottlesVal)

            if(ToggleBottlesVal)
                _SHMain.Bottles = true
            Else
                _SHMain.Bottles = false
            endif
        endif

        if(option == ToggleDiseases)
            ToggleDiseasesVal = !ToggleDiseasesVal
            SetToggleOptionValue(ToggleDiseases, ToggleDiseasesVal)

            if(ToggleDiseasesVal)
                _SHMain._SHDiseasesEnabled.SetValue(1)
                _SHMain.RemoveDiseases()
            Else
                _SHMain._SHDiseasesEnabled.SetValue(0)
                _SHMain.RemoveDiseases()
            endif
        endif

        if(option == ResetFormListsOption)
            bool b = ShowMessage("$AreYouSureReset")

            if(b)
                _SHMain.ModComp.ResetLists()
                ShowMessage("$ListsReset")
            endif
        endif

        if(option == ToggleEquipWaterskin)
            ToggleEquipWaterskinVal = !ToggleEquipWaterskinVal

            SetToggleOptionValue(ToggleEquipWaterskin, ToggleEquipWaterskinVal)

            if(ToggleEquipWaterskinVal)
                _SHMain._SHWaterskinEquip.SetValue(1.0)
            Else
                _SHMain._SHWaterskinEquip.SetValue(0)
            endif

        endif

        if(option == ToggleDisablePowers)
            Actor player = Game.GetPlayer()

            if(player.HasSpell(_SHMain._SHContinuanceSpell))
                player.RemoveSpell(_SHMain._SHContinuanceSpell)
                ShowMessage("$PowersRemoved")
            Else
                player.AddSpell(_SHMain._SHContinuanceSpell, false)
                ShowMessage("$PowersAdded")
            endif

            if(player.HasSpell(_SHMain._SHFillAllSpell))
                player.RemoveSpell(_SHMain._SHFillAllSpell)
            Else
                player.AddSpell(_SHMain._SHFillAllSpell, false)
            endif

        endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;              DISPLAY PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ElseIf (CurrentPage == "$DisplaySettings")

        ;toggle messages option
        if(option == ToggleMessages)
            ToggleMessagesVal = !ToggleMessagesVal
            SetToggleOptionValue(ToggleMessages, ToggleMessagesVal)

            If (ToggleMessagesVal)
                _SHMessagesEnabled.SetValue(1)
            Else
                _SHMessagesEnabled.SetValue(0)
            EndIf
        EndIf

        if(option == ToggleFirstPerson)
            ToggleFirstPersonVal = !ToggleFirstPersonVal
            SetToggleOptionValue(ToggleFirstPerson, ToggleFirstPersonVal)

            if(ToggleFirstPersonVal)
                _SHMain.FirstPersonMessages = true
            else
                _SHMain.FirstPersonMessages = false
            endif
        endif

        ;Toggle tutorial
        If (option == ToggleTuts)
            ToggleTutsVal = !ToggleTutsVal
            SetToggleOptionValue(ToggleTuts,ToggleTutsVal)

            If (ToggleTutsVal)
                _SHHungerTutEnabled.SetValue(1)
                _SHThirstTutEnabled.SetValue(1)
                _SHFatigueTutEnabled.SetValue(1)
                _SHWellBeingTutEnabled.SetValue(1)
            Else
                _SHHungerTutEnabled.SetValue(0)
                _SHThirstTutEnabled.SetValue(0)
                _SHFatigueTutEnabled.SetValue(0)
                _SHWellBeingTutEnabled.SetValue(0)
            EndIf
        EndIf

        ;Toggle sounds option
        If (option == ToggleSounds)
            ToggleSoundsVal = !ToggleSoundsVal
            SetToggleOptionValue(ToggleSounds,ToggleSoundsVal)

            If (ToggleSoundsVal)
                _SHMain.ToggleSounds = true
            else
                _SHMain.ToggleSounds = false
            EndIf
        EndIf

        ;Toggle Widgets
        If (option == ToggleWidgets)
            ToggleWidgetsVal = !ToggleWidgetsVal
            SetToggleOptionValue(ToggleWidgets,ToggleWidgetsVal)

            If (ToggleWidgetsVal)
                _SHMain.HideWidgets = false               
            else
                _SHMain.HideWidgets = true        
            EndIf

        EndIf

        if(option == ToggleDetailedContinuance)
            ToggleDetailedContinuanceVal = !ToggleDetailedContinuanceVal
            SetToggleOptionValue(ToggleDetailedContinuance,ToggleDetailedContinuanceVal)

            if (ToggleDetailedContinuanceVal)
                _SHMain.ToggleDetailedContin = true
            else
                _SHMain.ToggleDetailedContin = false
            endif

        endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;              NEEDS PAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ElseIf (CurrentPage == "$Needs")
        ;toggle death by needs option
        if(option == ToggleDeath)
            ToggleDeathVal = !ToggleDeathVal
            SetToggleOptionValue(ToggleDeath, ToggleDeathVal)

            if(ToggleDeathVal)
                _SHNeedsDeath.SetValue(1)
            Else
                _SHNeedsDeath.SetValue(0)
            EndIf
        EndIf

        if(option == TogglePauseOblivion)
            TogglePauseOblivionVal = !TogglePauseOblivionVal
            SetToggleOptionValue(TogglePauseOblivion, TogglePauseOblivionVal)

            if(TogglePauseOblivionVal)
                _SHMain.pauseNeedsInOblivion = true
            else
                _SHMain.pauseNeedsInOblivion = false
            endif
        endif

        if(option == ToggleDrunkFx)
            ToggleDrunkFxVal = !ToggleDrunkFxVal
            SetToggleOptionValue(ToggleDrunkFx, ToggleDrunkFxVal)

            if(ToggleDrunkFxVal)
                _SHDrunkSkoomaFX.SetValue(1)
            else
                _SHDrunkSkoomaFX.SetValue(0)
            endif
        endif

        if(option == ToggleWerewolfFatigue)
            ToggleWerewolfFatigueVal = !ToggleWerewolfFatigueVal
            SetToggleOptionValue(ToggleWerewolfFatigue,ToggleWerewolfFatigueVal)

            if(ToggleWerewolfFatigueVal)
                _SHMain.WerewolfFatigue = true
            Else
                _SHMain.WerewolfFatigue = false
            EndIf
        EndIf

        if(option == ToggleWerewolfPause)
            ToggleWerewolfPauseVal = !ToggleWerewolfPauseVal
            SetToggleOptionValue(ToggleWerewolfPause, ToggleWerewolfPauseVal)

            If (ToggleWerewolfPauseVal)
                _SHMain.WerewolfPauseNeeds = true
            Else
                _SHMain.WerewolfPauseNeeds = false
            EndIf
        EndIf

        if(option == VampireThirst)
            ToggleVampireThirstVal = !ToggleVampireThirstVal
            SetToggleOptionValue(VampireThirst, ToggleVampireThirstVal)

            if(ToggleVampireThirstVal)
                _SHMain.VampireThirst = true
            else
                _SHMain.VampireThirst = false
            endif
        EndIf

 ;;;;;;;;       FATIGUE     ;;;;;;;;;;;;;
        if(option == ToggleFatigue)
            ToggleFatigueVal = !ToggleFatigueVal
            SetToggleOptionValue(ToggleFatigue, ToggleFatigueVal)

            ShowMessage("$ExitMenu")

            if(ToggleFatigueVal)
                Debug.Notification("Enabling Fatigue needs.")
                _SHMain.StartFatigue()
            Else
                Debug.Notification("Disabling Fatigue needs.")
                _SHMain.StopFatigue()
            EndIf

        EndIf

 ;;;;;;;;       Thirst    ;;;;;;;;;;;;;
        if(option == ToggleThirst)
            ToggleThirstVal = !ToggleThirstVal
            SetToggleOptionValue(ToggleThirst, ToggleThirstVal)

            ShowMessage("$ExitMenu")

            if(ToggleThirstVal)
                Debug.Notification("Enabling Thirst needs.")
                _SHMain.StartThirst()
            Else
                Debug.Notification("Disabling Thirst needs.")
                _SHMain.StopThirst()
            EndIf
        EndIf

        ;OPTION DISABLED
 ;;;;;;;;       Hunger     ;;;;;;;;;;;;;

        if(option == ToggleHunger)
            ToggleHungerVal = !ToggleHungerVal
            SetToggleOptionValue(ToggleHunger, ToggleHungerVal)
            ShowMessage("$ExitMenu")

            if(ToggleHungerVal)
                Debug.Notification("Enabled Hunger needs.")
                _SHMain.StartHunger()
            Else
                Debug.Notification("Disabling Hunger needs.")
                _SHMain.StopHunger()
            EndIf

        EndIf

    ElseIf (CurrentPage == "$SkillTree")
        if(option == SurvivalRespec)
            bool b = ShowMessage("$AreYouSureRefund")

            if(b) 
                RefundSkillPoints()
                ShowMessage("$SkillPtsRestored", false)
            endif
        ElseIf(option == SurvivalRestore)
            bool b = ShowMessage("$OptionIntended")
            if b
                ShowMessage("$SelectTotalNumber")

                SetToggleOptionValue(SurvivalRestore, true , true)
                SetOptionFlags(SurvivalSkillRestoreSlider, OPTION_FLAG_NONE)
            endif
        endif

    ElseIf (CurrentPage == "$Help")
        if(option == NeedsHelp)
            ShowMessage("$NeedsHelpMessage")
        ElseIf(option == HungerHelp)
            ShowMessage("$HungerHelpMessage")
        ElseIf (option == ThirstHelp)
            ShowMessage("$ThirstHelpMessage")
        ElseIf (option == FatigueHelp)
            ShowMessage("$FatigueHelpMessage")
        ElseIf (option == RefillHelp)
            ShowMessage("$RefillHelpMessage")
        ElseIf (option == WerewolfHelp)
            ShowMessage("$WerewolfHelpMessage")
        ElseIf (option == VampireHelp)
            ShowMessage("$VampireHelpMessage")
        ElseIf (option == ArrowHelp)
            ShowMessage("$ArrowHelp")
        Endif

    EndIf

EndEvent

Event OnOptionHighlight(int option)

    if(CurrentPage == "$GeneralSettings")
        if(option == ToggleMod)
            SetInfoText("$SHToggleModDesc")
        ElseIf (option == ToggleTravelDisable)
            SetInfoText("$SHToggleFTDesc")
        ElseIf (option == ToggleAnims)
            SetInfoText("$SHToggleAnimsDesc")
        ElseIf (option == DrinkAndFillHotkeyOption)
            SetInfoText("$DrinkAndFillHkInfo")
        ElseIf (option == ToggleRefill)
            SetInfoText("$SHToggleRefillDesc")
        ElseIf (option == ToggleRawDamage)
            SetInfoText("$SHToggleRawDesc")
        ElseIf(option == ToggleCarryWeightPen)
            SetInfoText("$SHToggleCWPenDesc")
        ElseIf (option == ToggleArrowOption)
            SetInfoText("$SHArrowWeighDesc")
        ElseIf (option == ResetFormListsOption)
            SetInfoText("$SHResetDesc")
        ElseIf (option == ToggleEquipWaterskin)
            SetInfoText("$SHWaterskinInfo")
        ElseIf (option == WaterskinLocationOption)
            SetInfoText("$WaterskinLocationInfo")
        ElseIf (option == ToggleBottles)
            SetInfoText("$ToggleBottleInfo")
        ElseIf(option == ToggleDisablePowers)
            SetInfoText("$TogglePowersInfo")
        endif
    elseif(CurrentPage == "$DisplaySettings")
        If (option == ToggleMessages)
            SetInfoText("$SHToggleMsgDesc")
        ElseIf (option == ToggleTuts)
            SetInfoText("$SHToggleTutsDesc")
        ElseIf (option == WidgetXOption)
            SetInfoText("$SHWidgXOptionDesc")
        ElseIf (option == WidgetYOption)
            SetInfoText("$SHWidgYOptionDesc")
        ElseIf (option == ToggleWidgets)
            SetInfoText("$SHToggleWidgDesc")
        ElseIf (option == WidgetOrientation)
            SetInfoText("$SHWidgetOrientDesc")
        ElseIf (option == WidgetDisplayType)
            SetInfoText("$SHDisplayTypeDesc")
        ElseIf (option == WidgetPreset)
            SetInfoText("$SHPresetDesc")
        ElseIf (option == ToggleSounds)
            SetInfoText("$SHToggleSoundsDesc")
        ElseIf (option == ToggleFirstPerson)
            SetInfoText("$ToggleFirstInfo")
        ElseIf (option == ContinuanceHotkeyOption)
            SetInfoText("$ContinuanceHkInfo")
        endif
    elseif(CurrentPage == "$Needs")
        If (option == ToggleDeath)
            SetInfoText("$SHToggleDamageDesc")       
        ElseIf (option == ToggleWerewolfFatigue)
            SetInfoText("$SHWereFatigueDesc")
        ElseIf (option == ToggleWerewolfPause)
            SetInfoText("$SHWerePauseDesc")
        ElseIf (option == VampireOptions)
            SetInfoText("$SHVampireOptDesc")
        ElseIf (option == VampireThirst)
            SetInfoText("$SHVampireThirstDesc")
        ElseIf (option == ToggleCannibal)
            SetInfoText("$SHCannibalDesc")
        ElseIf (option == WerewolfFill)
            SetInfoText("$SHWerewolfFillDesc")
        ElseIf (option == HungerRateOption)
            SetInfoText("$SHHungerRateDesc")
        ElseIf (option == ThirstRateOption)
            SetInfoText("$SHThirstRateDesc")
        ElseIf (option == FatigueRateOption)
            SetInfoText("$SHFatigueRateDesc")
        elseif(option == AlcoholDrinksOption)
            SetInfoText("$SHAlcoholNumDesc")
        elseif(option == ToggleDrunkFx)
            SetInfoText("$SHVisualEffects")
        ElseIf (option == ToggleHunger)
            SetInfoText("$SHToggleHungerDesc")
        ElseIf (option == ToggleThirst)
            SetInfoText("$SHToggleThirstDesc")
        ElseIf (option == ToggleFatigue)
            SetInfoText("$SHToggleFatigueDesc")
        endif
    elseif(CurrentPage == "$SkillTree")
        If (option == SurvivalRespec)
            SetInfoText("$SHSurvRespecDesc")
        ElseIf(option == SurvivalRestore)
            SetInfoText("$SHSurvRestoreDesc")
        endif
    elseif(CurrentPage == "$Help")

    endif
EndEvent

Event OnOptionMenuOpen(int option)

    if(option == ToggleMod)
        SetMenuDialogOptions(ModToggleArray)
        SetMenuDialogStartIndex(IndexToggleMod)
        SetMenuDialogDefaultIndex(1)

    ElseIf (option == WerewolfFill)
        SetMenuDialogOptions(WerewolfFillArray)
        SetMenuDialogStartIndex(IndexWerewolfFill)
        SetMenuDialogDefaultIndex(0)

    ElseIf (option == VampireOptions)
        SetMenuDialogOptions(VampireOptionArray)
        SetMenuDialogStartIndex(IndexVampire)
        SetMenuDialogDefaultIndex(0)

    elseif(option == WidgetOrientation)
        SetMenuDialogOptions(OrientationArray)
        SetMenuDialogStartIndex(IndexOrientation)
        SetMenuDialogDefaultIndex(1)

    elseif(option == WidgetDisplayType)
        SetMenuDialogOptions(WidgetDisplayArray)
        SetMenuDialogStartIndex(IndexWidgetDisplay)
        SetMenuDialogDefaultIndex(2)
        
    elseif(option == WidgetPreset)
        SetMenuDialogOptions(WidgetPresetArray)
        SetMenuDialogStartIndex(IndexWidgetPreset)
        SetMenuDialogDefaultIndex(3)

    ElseIf (option == WaterskinLocationOption)
        SetMenuDialogOptions(WaterskinArray)
        SetMenuDialogStartIndex(IndexWaterskin)
        SetMenuDialogDefaultIndex(0)
    EndIf
EndEvent

Event OnOptionMenuAccept(int option, int index)

    if(option == ToggleMod)
        IndexToggleMod = index
        SetMenuOptionValue(ToggleMod, ModToggleArray[IndexToggleMod])

        if(index == 0)
            ShowMessage("$ModStopping")
            ForcePageReset()
        else
            ShowMessage("$ModStarting")
        endif
        
    ElseIf (option == WerewolfFill)
        IndexWerewolfFill = index
        SetMenuOptionValue(WerewolfFill, WerewolfFillArray[IndexWerewolfFill])

        if(IndexWerewolfFill == 0)
            _SHMain.WerewolfFeedOptions = 1
        ElseIf (IndexWerewolfFill == 1)
            _SHMain.WerewolfFeedOptions = 2
        ElseIf (IndexWerewolfFill == 2)
            _SHMain.WerewolfFeedOptions = 3
        EndIf
    
    ElseIf (option == VampireOptions)
        IndexVampire = index
        SetMenuOptionValue(VampireOptions,VampireOptionArray[IndexVampire])

        if(IndexVampire == 0)
            _SHMain.VampireNeedsOption = 1
            _SHMain.VampireChangeNeeds(1)
        ElseIf (IndexVampire == 1)
            _SHMain.VampireNeedsOption = 2
            _SHMain.VampireChangeNeeds(2)
        ElseIf (IndexVampire == 2)
            _SHMain.VampireNeedsOption = 3
            _SHMain.VampireChangeNeeds(3)
        endif
    elseif(option == WidgetOrientation)
        IndexOrientation = index
        SetMenuOptionValue(WidgetOrientation, OrientationArray[IndexOrientation])

        if(IndexOrientation == 0)
            _SHMain.Orientation = 0
        Else
            _SHMain.Orientation = 1
        EndIf

        ;Redo widget preset locations
        if(IndexWidgetPreset == 0)
            _SHMain.SetWidgetPresetLocations(0)
        ElseIf (IndexWidgetPreset == 1)
            _SHMain.SetWidgetPresetLocations(1)
        ElseIf (IndexWidgetPreset == 2)
            _SHMain.SetWidgetPresetLocations(2)
        ElseIf (IndexWidgetPreset == 3)
            _SHMain.SetWidgetPresetLocations(3)            
        EndIf

    elseif(option == WidgetDisplayType)
        IndexWidgetDisplay = index

        SetMenuOptionValue(WidgetDisplayType,WidgetDisplayArray[IndexWidgetDisplay])

        If (IndexWidgetDisplay == 0)
            _SHMain.DisplayType = 0
        Elseif(IndexWidgetDisplay == 1)
            _SHMain.DisplayType = 1
        Else
            _SHMain.DisplayType = 2
        EndIf

    ElseIf (option == WidgetPreset)
        IndexWidgetPreset = index

        SetMenuOptionValue(WidgetPreset,WidgetPresetArray[IndexWidgetPreset])

        if(IndexWidgetPreset == 0)
            _SHMain.SetWidgetPresetLocations(0)
        ElseIf (IndexWidgetPreset == 1)
            _SHMain.SetWidgetPresetLocations(1)
        ElseIf (IndexWidgetPreset == 2)
            _SHMain.SetWidgetPresetLocations(2)
        ElseIf (IndexWidgetPreset == 3)
            _SHMain.SetWidgetPresetLocations(3)            
        EndIf

        WidgetXNoOffset = _SHMain.WidgetX
        WidgetYNoOffset = _SHMain.WidgetY

        WidgetXVal = 0
        WidgetYVal = 0

    ElseIf (option == WaterskinLocationOption)
        IndexWaterskin = index

        SetMenuOptionValue(WaterskinLocationOption, WaterSkinArray[IndexWaterskin])

    EndIf

    
EndEvent

Event OnKeyDown(Int KeyCode)
	UnregisterForKey(DrinkAndFillHotkey)
    UnregisterForKey(ContinuanceHotkey)
    
    If !UI.IsTextInputEnabled() && !Utility.IsInMenuMode()
        if(KeyCode == DrinkAndFillHotkey)
            _SHMain.DrinkAndFill()
        ElseIf (KeyCode == ContinuanceHotkey)
            _SHMain.ContinuancePower()
        endif   
    endif

    if(DrinkAndFillHotkey > -1)
        RegisterForKey(DrinkAndFillHotkey)
    endif
    if(ContinuanceHotkey > -1)
        RegisterForKey(ContinuanceHotkey)
    endif
endEvent

Function RefundSkillPoints()
    _SHMain._SHPerkPoints.SetValue(_SHMain._SHPerkPointsEarned.GetValue())
    _SHMain._SHPerkPointsProgress.SetValue(0.0)
EndFunction

Function ClearSurvivalPerks()
    ;Clear perks
    _SHMain._SH_PerkRank_Unyielding.SetValue(0.0)
    _SHMain._SH_PerkRank_Hydrated.SetValue(0.0)
    _SHMain._SH_PerkRank_AbleBodied.SetValue(0.0)
    _SHMain._SH_PerkRank_Connoisseur.SetValue(0.0)
    _SHMain._SH_PerkRank_Vigorous.SetValue(0.0)
EndFunction

Function ApplyModStatus()

    if((IndexWaterskin != _SHMain.WaterskinLocation) || !ToggleEquipWaterskinVal)
        _SHMain._SHWaterskinEquip.SetValue(0.0)
        _SHMain.WaterskinLocation = IndexWaterskin      
    endif

    ;_SHMain.SetDiseaseGameSettingString()

    if(IndexToggleMod == 0)
        if(_SHEnabled.GetValue() == 1)
            _SHMain.StopMod()
        EndIf
    Else
        if(_SHEnabled.GetValue() == 0)
            _SHMain.StartMod()
        EndIf
    EndIf  

    UnregisterForKey(DrinkAndFillHotkey)
    UnregisterForKey(ContinuanceHotkey)

    if(DrinkAndFillHotkey > -1)
        RegisterForKey(DrinkAndFillHotkey)
    endif
    if(ContinuanceHotkey > -1)
        RegisterForKey(ContinuanceHotkey)
    endif

    ;if(_SHEnabled.GetValue() == 1 && IndexToggleMod == 1)
    ;    if(ToggleFatigueVal)
    ;        _SHMain.StartFatigue()
    ;    Else
    ;        _SHMain.StopFatigue()
    ;    EndIf

    ;    if(ToggleThirstVal)
    ;        _SHMain.StartThirst()
    ;    Else
    ;        _SHMain.StopThirst()
    ;    EndIf
    ;    
    ;    if(ToggleHungerVal)
    ;        _SHMain.StartHunger()
    ;    Else
    ;        _SHMain.StopHunger()
    ;    EndIf
    ;endif

    Utility.Wait(1.5)

    if(ToggleEquipWaterskinVal)
        _SHMain._SHWaterskinEquip.SetValue(1.0)
    endif

    SendModEvent("_SH_WidgetUi") 
    
EndFunction

Event OnConfigClose()
    ApplyModStatus()
EndEvent