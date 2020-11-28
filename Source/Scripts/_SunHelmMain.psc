Scriptname _SunHelmMain extends Quest
;This script attaches to the main SH quest
;Also handles need startups

_SH_MCMScript property _SHMcm auto
_SHPlayerScript property _SHPlayer auto
Quest property _SHStart auto
Quest property _SHDialogueQuest auto

;Properties
Actor property Player auto

Activator property _SH_PerkNodeController auto

;Globals
GlobalVariable Property _SHEnabled Auto
GlobalVariable Property _SHDisableFT auto
GlobalVariable Property _SHTutsEnabled auto
GlobalVariable property _SHFirstTimeEnabled auto
GlobalVariable property _SHCannibalism auto
GlobalVariable property _SHRawDamage auto
GlobalVariable property _SHCarryWeight auto
GlobalVariable property _SHEnableArrowSleep auto
GlobalVariable property _SHWaterskinEquip auto

GlobalVariable property _SHPerkPoints auto
GlobalVariable property _SHPerkPointsEarned auto
GlobalVariable property _SHPerkPointsTotal auto
GlobalVariable property _SHPerkPointsProgress auto

GlobalVariable property _SH_PerkRank_AbleBodied auto
GlobalVariable property _SH_PerkRank_Connoisseur auto
GlobalVariable property _SH_PerkRank_Hydrated auto
GlobalVariable property _SH_PerkRank_Unyielding auto
GlobalVariable property _SH_PerkRank_Vigorous auto

GlobalVariable Property _SHDiseasesEnabled Auto
WorldSpace Property Tamriel Auto
WorldSpace Property DLC2SolstheimWorld Auto

;Spells
Spell Property _SHConfigSpell Auto
Spell Property _SHPlayerSpell auto
Spell property _SHContinuanceSpell auto
Spell property _SHFillAllSpell auto
Spell property _SH_Campfire_Spell auto
Spell property _SHDrunkSpell auto
Spell property _SHSkoomaSpell auto
Spell property _SHFoodPoisoningSpell auto
Spell property _SHAlchCureDisease auto

Ingredient Property SaltPile Auto

ConstructibleObject Property RecipeFoodBeefCooked Auto
ConstructibleObject Property RecipeFoodChickenCooked Auto
ConstructibleObject Property RecipeFoodGoatCooked Auto
ConstructibleObject Property RecipeFoodHorkerCooked Auto
ConstructibleObject Property RecipeFoodHorseCooked Auto
ConstructibleObject Property RecipeFoodMammothCooked Auto
ConstructibleObject Property RecipeFoodPheasantCooked Auto
ConstructibleObject Property RecipeFoodRabbitCooked Auto
ConstructibleObject Property RecipeFoodSalmonCooked Auto
ConstructibleObject Property RecipeFoodVenisonCooked Auto

Formlist property _SHDiseaseFormlist auto

;Scripts
_SHHungerSystem Property Hunger Auto
_SHThirstSystem Property Thirst Auto
_SHFatigueSystem Property Fatigue Auto
_SHWellBeing Property WellBeing Auto
_SHCompatabilityScript Property ModComp auto

;Messages
Message Property _SHSleepStartMessage Auto
Message Property _SHHelpStartMessage Auto
Message Property _SHPerkEarned auto
Message Property _SHPerkProgressed auto
Message Property _SHPerkEarnedFirst auto
Message Property _SHPerkProgressedFirst auto

Message Property _SHCarriageTravel auto
Message Property _SHCarriageTravelFirst auto
Message Property _SHBedroll auto
Message Property _SHBedrollFirst auto
Message Property _SHOblivionBack auto
Message Property _SHOblivionBackFirst auto

Message Property _SHStandWater auto
Message Property _SHStandWaterFirst auto

;Leveled
LeveledItem property LItemFoodInnCommon auto
LeveledItem property LItemBarrelFoodSame75 auto
LeveledItem property DLC2LootBanditRandom auto
LeveledItem property LootBanditRandom auto
LeveledItem property DLC2LootBanditRandomWizard auto
LeveledItem property LootBanditRandomWizard auto

LeveledItem property _SHLLWaterSkin15 auto
LeveledItem property _SHLLWater15 auto
LeveledItem property _SHLLWater25 auto

;potions
Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHWaterskin_3 auto
Potion property _SHWaterskinSalt auto

Potion property _SHSujammaWaterBottle auto

Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto

Sound property _SHDrink auto
Sound property _SHFillWaterM auto

;bools
bool property InWater auto
bool property AnimationsEnabled auto
bool property SexMale auto
bool property RefillAnims = true auto
bool property ToggleSounds auto
bool property SKSEInstalled = false auto
bool property BeastWerewolf auto
bool property HumanWerewolf auto
bool property WerewolfFatigue = true auto
bool property WerewolfPauseNeeds = true auto
bool property Vampire auto
bool property VampireThirst = true auto
bool property CampfireInstalled = false auto
bool property CarriageTravelled auto
bool property BedrollSleep = false auto
bool property introMessageShown = false auto
bool property ExpectedSurvival = true auto
bool property IsRidingDragon = false auto
bool property RemoveSalt = true auto
bool property FirstPersonMessages = true auto
bool property Bottles = true auto  
bool property MCMCannibal = false auto
bool property ToggleDetailedContin = true auto
bool property HasFoodPoison = false auto

bool property LLItemsAdded = false auto hidden
;Misc
int property SKSEVersion auto
MiscObject property _SHMeadEmptyMisc auto
MiscObject property _SHWineEmptyMisc auto
MiscObject property _SHWaterskinEmpty auto
int property WaterskinLocation = 0 auto

Perk property _SHCannibalPerks auto
Perk property _SHMiscActivations auto

;Widget Properties
Float property WidgetAlphaLevel = 100.00 auto
bool property HideWidgets = false auto
int property Orientation = 1 auto
int property WidgetX = 1175 auto
int property WidgetY = 721 auto
int property DisplayType = 1 auto
int property WerewolfFeedOptions = 1 auto
int property VampireNeedsOption = 1 auto
int property _SHNumDrinks = 3 auto
int property _SHDrinksConsumed auto

Idle Property idlepickup_ground Auto
Idle Property IdleStop_Loose Auto

Keyword property IsBeastRace auto
Keyword property _SH_LightFoodKeyword auto
Keyword property _SH_MediumFoodKeyword auto
Keyword property _SH_HeavyFoodKeyword auto
Keyword property _SH_SoupKeyword auto
;Keyword property _SH_RawKeyword auto
Keyword property _SH_MeadBottleKeyword auto
Keyword property _SH_WineBottleKeyword auto
Keyword property _SH_SujammaBottleKeyword auto

Keyword property _SH_MeadWATERBottleKeyword auto
Keyword property _SH_WineWATERBottleKeyword auto
Keyword property _SH_SujammaWATERBottleKeyword auto

Keyword property _SH_DrinkKeyword auto
Keyword property _SH_AlcoholDrinkKeyword auto
Keyword property _SHSaltWaterKeyword auto

Keyword property VendorItemFoodRaw auto

Race property WoodElfRace auto

float property ModVersion auto


;Oblivion variables

Message property _SHOblivionMessage auto
Message property _SHOblivionMessageFirst auto
bool property isInOblivion auto
FormList property _SHOblivionWorlds auto
FormList property _SHOblivionLctns auto
FormList property _SHOblivionCells auto
bool property pauseNeedsInOblivion = true auto
bool property wasInOblivion = false auto
bool lockSurvival = false
bool progress25 = false
bool progress50 = false
bool progress75 = false

;----Strings------

string property NoSKSE = "SKSE NOT INSTALLED. SUNHELM MAY NOT FUNCTION PROPERLY" auto
string property NoSkyUI = "SkyUI not installed. A limited config spell can be used to start the mod, but settings wont be available." auto
;Events

;Oninit fires when the quest is first initialized
;Adds the spell and then is started with the config
Event Oninit()
    
    CheckForUpdate()

    AddDrinksAndOthersToList()
    RegisterForSleep()

    RegisterForSingleUpdate(5)  
EndEvent

;When a stop sleep event is caught, start the mod up
Event OnSleepStop(bool abInterrupted)

    If (_SHEnabled.GetValue() == 0)
        int option = _SHSleepStartMessage.Show()
        introMessageShown = true
        If (option == 0)
            StartMod()
        EndIf
    EndIf
    SendModEvent("_SH_UpdateWidget")        ;DEBUG
    UnregisterForSleep()
EndEvent
;Functions

;Stop updating when mod is enabled
Event OnUpdate()

    ;Dont enable during intro
    if !Game.IsFightingControlsEnabled() || Player.IsInInterior()
		RegisterForSingleUpdate(5)
		return
    endif
    
    if(_SHStart.GetStage() == 0)
        _SHStart.SetStage(10)
    endif

endEvent

Function CheckGameInfo()

    Player = game.GetPlayer()

    if(!Game.GetFormFromFile(0x00000802, "SkyUI_SE.esp"))
        Player.AddSpell(_SHConfigSpell, False)
        Debug.Notification(NoSkyUI)
    Else
        SKSEVersion = SKSE.GetVersion() 
        if(SKSEVersion > 0)
            SKSEInstalled = true
        Else
            Debug.Notification(NoSKSE)
        EndIf
    EndIf

    GlobalVariable CampfireAPIVersion = Game.GetFormFromFile(0x03F1BE, "Campfire.esm") as GlobalVariable
    if CampfireAPIVersion.GetValueInt() >= 4
        CampfireInstalled = true
    endif

    If Player.GetActorBase().GetSex() == 0
        SexMale = True
    Else
        SexMale = False
    EndIf

EndFunction

Function CheckForUpdate()

    CheckGameInfo()

    ;if(SKSEInstalled && RemoveSalt)
    ;    RemoveSalt(RecipeFoodBeefCooked)
    ;    RemoveSalt(RecipeFoodChickenCooked)
    ;    RemoveSalt(RecipeFoodGoatCooked)
    ;    RemoveSalt(RecipeFoodHorkerCooked)
    ;    RemoveSalt(RecipeFoodHorseCooked)
    ;    RemoveSalt(RecipeFoodMammothCooked)
    ;    RemoveSalt(RecipeFoodPheasantCooked)
    ;    RemoveSalt(RecipeFoodRabbitCooked)
    ;    RemoveSalt(RecipeFoodSalmonCooked)
    ;    RemoveSalt(RecipeFoodVenisonCooked)
    ;endif

    ;If a mod version is set
    if(ModVersion)
        ;Check for update
        if(ModVersion < 1.93)
            
            int alreadyEnabled = _SHEnabled.GetValue() as int
            ;Refresh the mod
            StopMod()
            
            if(alreadyEnabled == 1)
                StartMod()
            endif

            ModComp.CleanLists()
            
            Debug.Notification("SunHelm is updated to: 1.2.1")
        endif
    endif
    ModVersion = 1.93 ;ie 1.2.1

    ModComp.CheckMods()
EndFunction

;Startup for the 
Function StartMod()
    If (_SHEnabled.GetValue() == 0)
        _SHEnabled.SetValue(1)
        Player.AddSpell(_SHPlayerSpell, false)
        _SHDialogueQuest.Start()

        if(ExpectedSurvival)
            _SHEnableArrowSleep.SetValue(1)
        endif

        ;Have to remove in case player already had a disease when enabling.
        RemoveDiseases()

        ;Auto enable cannibalism
        if(Game.GetPlayer().GetRace() == WoodElfRace)
            _SHCannibalism.SetValue(1)
        Elseif(MCMCannibal)
            ;enable cannibal if it was before
            _SHCannibalism.SetValue(1)
        endif

        ;Start player updates
        _SHPlayer.stopUpdating = false
        wasInOblivion = false
        _SHPlayer.Update()
        
        AddPowers()
        Player.AddPerk(_SHCannibalPerks)   ;Removed in favor of updated cannibal mechanics
        Player.AddPerk(_SHMiscActivations)
        Player.AddSpell(_SH_Campfire_Spell, false)
               
        if(!introMessageShown)
            Utility.Wait(1)     
            _SHHelpStartMessage.Show()
            introMessageShown = true
        endif
        
        if(!Vampire)
            StartSystems()
        else
            VampireChangeNeeds(VampireNeedsOption)
        endif
        
        if(CampfireInstalled)
            CampUtil.RegisterPerkTree(_SH_PerkNodeController, "SunHelmSurvival.esp")
        endif
        
        ;Leave ft alone if frostfall is installed.
        if(!ModComp.FrostfallInstalled)    
            If (_SHDisableFT.GetValue() == 1)
                Game.EnableFastTravel(false)
            EndIf
        Endif

        ;SetDiseaseGameSettingString()

        _SHStart.SetStage(20)
    Else
        Debug.Notification("SunHelm already enabled...")
    EndIf
    _SHFirstTimeEnabled.SetValue(0)
EndFunction

;Disabled. Could cause CTD in certain scenarios with Engine Fixes.
Function SetDiseaseGameSettingString()

    if(SKSEInstalled)
        if(_SHEnabled.GetValue() == 1 && _SHDiseasesEnabled.GetValue() == 1)           
            if(FirstPersonMessages)
                Game.SetGameSettingString("sContractedDisease", "I have contracted")
            else
                Game.SetGameSettingString("sContractedDisease", "You have contracted")
            endif
        endif
    endif
endFunction

;Stops the mod ie. removes effects etc.
Function StopMod()
    If (_SHEnabled.GetValue() == 1)
        _SHEnabled.SetValue(0)
        _SHPlayer.stopUpdating = true
        _SHDialogueQuest.Stop()
        RemovePowers()
        RemoveDiseases()
        Player.RemoveSpell(_SH_Campfire_Spell)
        Player.RemoveSpell(_SHPlayerSpell)

        _SHEnableArrowSleep.SetValue(0)
        
        StopSystems()
        Player.RemovePerk(_SHCannibalPerks)
        Player.RemovePerk(_SHMiscActivations)

        Game.EnableFastTravel(true)

        if (CampfireInstalled)
            CampUtil.UnregisterPerkTree(_SH_PerkNodeController, "SunHelmSurvival.esp")
        endif

        ;SetDiseaseGameSettingString()
    Else
        Debug.Notification("SunHelm already disabled...")
    EndIf
EndFunction

Function RemovePowers()
    Player.RemoveSpell(_SHContinuanceSpell)
    Player.RemoveSpell(_SHFillAllSpell)
endFunction

Function AddPowers()
    Player.AddSpell(_SHContinuanceSpell, false)
    Player.AddSpell(_SHFillAllSpell, false)
endFunction

Function AdvanceSurvivalSKill()    
    if(CampfireInstalled)

        ;semaphore to avoid race conditions
        while(lockSurvival)
            ;wait until whatever has this method locked to be done
        EndWhile

        lockSurvival = true

        if(_SHPerkPointsEarned.GetValue() < _SHPerkPointsTotal.GetValue())
            int next_level = _SHPerkPointsEarned.GetValueInt() + 1
            float actions_required
            ;hours_required = (next_level * 3)
            actions_required = (6 + ((next_level * 2) * 6)) 

            float progress_value = (1.0 / actions_required)

            _SHPerkPointsProgress.SetValue(_SHPerkPointsProgress.GetValue() + progress_value)

            if (_SHPerkPointsProgress.GetValue() + 0.01) >= 1.0
                
                if(FirstPersonMessages)
                    _SHPerkEarnedFirst.Show()                  
                else
                    _SHPerkEarned.Show()
                endif
                
                _SHPerkPointsEarned.SetValueInt(_SHPerkPointsEarned.GetValueInt() + 1)
                _SHPerkPoints.SetValueInt(_SHPerkPoints.GetValueInt() + 1)

                if _SHPerkPointsEarned.GetValueInt() >= _SHPerkPointsTotal.GetValueInt()
                    _SHPerkPointsProgress.SetValue(1.0)
                else
                    _SHPerkPointsProgress.SetValue(0.0)
                endif
            else
                float perkProg = _SHPerkPointsProgress.GetValue() + 0.01
                bool showMessage = false

                ;Only show message at certain intervals
                if(perkProg >= 0.25 && perkProg < 0.50)                  
                    if(!progress25)
                        showMessage = true
                    else
                        showMessage = false
                    endif
                    progress25 = true
                    progress50 = false
                    progress75 = false
                ElseIf(perkProg >= 0.50 && perkProg < 0.75)
                    if(!progress50)
                        showMessage = true
                    else
                        showMessage = false
                    endif
                    progress25 = false
                    progress50 = true
                    progress75 = false            
                ElseIf(perkProg >= 0.75 && perkProg < 1.0)
                    if(!progress75)
                        showMessage = true
                    else
                        showMessage = false
                    endif
                    progress25 = false
                    progress50 = false
                    progress75 = true 
                endif

                if(showMessage)
                    if(FirstPersonMessages)
                        _SHPerkProgressedFirst.Show()
                    else
                        _SHPerkProgressed.Show()
                    endif
                endif         
            endif
        endif
        lockSurvival = false
    endif
EndFunction

Function DrinkAndFill()
    Player = Game.GetPlayer()

    if(InWater)
        ;Check bottles
        int meadCount
        meadCount = Player.GetItemCount(_SHEmptyMeadMisc)
        if(meadCount > 0)
            Player.RemoveItem(_SHEmptyMeadMisc,meadCount)
        endif

        int skinCount
        skinCount = Player.GetItemCount(_SHWaterskinEmpty)
        if(skinCount > 0)
            Player.RemoveItem(_SHWaterskinEmpty,skinCount)
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

        if(AnimationsEnabled)
            if(wineCount > 0 || meadCount > 0 || sujammaCount > 0 || skinCount > 0)
                PlayFillAnimation()
            else
                ;Dont play fill sounds
                PlayFillAnimation(false)
            endif
        endif

        ;Fresh Water
        if(!IsInSaltwater())
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
                Player.AddItem(_SHWaterskin_3, skinCount)
            endif

            _SHDrink.Play(Player)
            if(Thirst.IsRunning())
                Thirst.DecreaseThirstLevel(40)
            endif

        ;SaltWater
        else
            
            if(meadCount > 0)
                Player.AddItem(_SHSaltBottleMead, meadCount)
            endif

            if(wineCount > 0)
                Player.AddItem(_SHSaltBottleWine, wineCount)
            endif

            if(sujammaCount > 0)
                Player.AddItem(_SHSaltBottleSujamma, sujammaCount)
            endif

            if(skinCount > 0)
                Player.AddItem(_SHWaterskinSalt, skinCount)
            endif          
        endif
    Else
        if(FirstPersonMessages)
            _SHStandWaterFirst.Show()
        else
            _SHStandWater.Show()
        endif
    endif
endFunction

Function RemoveSalt(ConstructibleObject Recipe)
	Int i = 0
	While i < Recipe.GetNumIngredients()
		If Recipe.GetNthIngredient(i) == SaltPile
			Recipe.SetNthIngredientQuantity(0, i)
			Return
		Else
			i += 1
		EndIf
	EndWhile
EndFunction

Function AddSalt(ConstructibleObject Recipe)
    Int i = 0
	While i < Recipe.GetNumIngredients()
		If Recipe.GetNthIngredient(i) == SaltPile
			Recipe.SetNthIngredientQuantity(1, i)
			Return
		Else
			i += 1
		EndIf
	EndWhile
EndFunction

Function AlcoholDrink()

    _SHDrinksConsumed = _SHDrinksConsumed + 1
    Player = Game.GetPlayer()

    if(_SHDrinksConsumed >= _SHNumDrinks)
        _SHDrinksConsumed = 0   ;Reset drink count

        ;Player.AddSpell(_SHDrunkSpell)
        _SHDrunkSpell.Cast(Player,PLayer)

    endif
EndFunction

Function ResetDrinkCount()

    _SHDrinksConsumed = 0

EndFunction

Function RemoveDiseases()

	Int i = 0
	while i < _SHDiseaseFormlist.GetSize()
		Player.RemoveSpell(_SHDiseaseFormlist.GetAt(i) as spell)
		i += 1
    endWhile
    
    _SHAlchCureDisease.Cast(Game.GetPlayer(),Game.GetPlayer())
endfunction


Function ContinuancePower()

    int CurrentHungerStage = Hunger.CurrentHungerStage

    If (CurrentHungerStage == 0)
        if(FirstPersonMessages)
            Hunger._SHHunger0First.Show()
        else
            Hunger._SHHunger0.Show()
        endif
    ElseIf (CurrentHungerStage == 1)
        if(FirstPersonMessages)
            Hunger._SHHunger1First.Show()
        else
            Hunger._SHHunger1.Show()
        endif
    ElseIf (CurrentHungerStage == 2)
        if(FirstPersonMessages)
            Hunger._SHHunger2First.Show()
        else
            Hunger._SHHunger2.Show()
        endif
    ElseIf (CurrentHungerStage == 3)
        if(FirstPersonMessages)
            Hunger._SHHunger3First.Show()
        else
            Hunger._SHHunger3.Show()
        endif
    ElseIf (CurrentHungerStage == 4)
        if(FirstPersonMessages)
            Hunger._SHHunger4First.Show()
        else
            Hunger._SHHunger4.Show()
        endif
    ElseIf (CurrentHungerStage == 5)
        if(FirstPersonMessages)
            Hunger._SHHunger5First.Show()
        else
            Hunger._SHHunger5.Show()
        endif
    EndIf

    if(ToggleDetailedContin)
        Debug.Notification("Hunger: " + Hunger._SHCurrentHungerLevel.GetValue())
    endif

    int CurrentFatigueStage = Fatigue.CurrentFatigueStage

    If (CurrentFatigueStage == 0)
        if(FirstPersonMessages)
            Fatigue._SHFatigue0First.Show()
        else
            Fatigue._SHFatigue0.Show()
        endif
    ElseIf (CurrentFatigueStage == 1)
        if(FirstPersonMessages)
            Fatigue._SHFatigue1First.Show()
        else
            Fatigue._SHFatigue1.Show()
        endif
    ElseIf (CurrentFatigueStage == 2)
        if(FirstPersonMessages)
            Fatigue._SHFatigue2First.Show()
        else
            Fatigue._SHFatigue2.Show()
        endif
    ElseIf (CurrentFatigueStage == 3)
        if(FirstPersonMessages)
            Fatigue._SHFatigue3First.Show()
        else
            Fatigue._SHFatigue3.Show()
        endif
    ElseIf (CurrentFatigueStage == 4)
        if(FirstPersonMessages)
            Fatigue._SHFatigue4First.Show()
        else
            Fatigue._SHFatigue4.Show()
        endif
    ElseIf (CurrentFatigueStage == 5)
        if(FirstPersonMessages)
            Fatigue._SHFatigue5First.Show()
        else
            Fatigue._SHFatigue5.Show()
        endif
    EndIf

    if(ToggleDetailedContin)
        Debug.Notification("Fatigue: " + Fatigue._SHCurrentFatigueLevel.GetValue())
    endif

    int CurrentThirstStage = Thirst.CurrentThirstStage

    If (CurrentThirstStage == 0)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage0First.Show()
        else
            Thirst._SHThirstMessage0.Show()
        endif
    ElseIf (CurrentThirstStage == 1)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage1First.Show()
        else
            Thirst._SHThirstMessage1.Show()
        endif
    ElseIf (CurrentThirstStage == 2)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage2First.Show()
        else
            Thirst._SHThirstMessage2.Show()
        endif
    ElseIf (CurrentThirstStage == 3)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage3First.Show()
        else
            Thirst._SHThirstMessage3.Show()
        endif
    ElseIf (CurrentThirstStage == 4)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage4First.Show()
        else
            Thirst._SHThirstMessage4.Show()
        endif
    ElseIf (CurrentThirstStage == 5)
        if(FirstPersonMessages)
            Thirst._SHThirstMessage5First.Show()
        else
            Thirst._SHThirstMessage5.Show()
        endif
    EndIf

    if(ToggleDetailedContin)
        Debug.Notification("Thirst: " + Thirst._SHCurrentThirstLevel.GetValue())
        Debug.Notification("Well Being: " + WellBeing._SHWellBeingLevel.GetValue())
    endif

EndFunction

Function CheckPlayerIsInOblivion(bool InOblivion)

    if(!InOblivion)
        isInOblivion = false
    endif

    if(pauseNeedsInOblivion)

        ;location playerLocation = Player.GetCurrentLocation()
        ;cell playerCell = Player.GetParentCell()
        ;Worldspace currentSpace = Player.GetWorldSpace()

        ;isInOblivion =  _SHOblivionLctns.HasForm(playerLocation as form) || _SHOblivionWorlds.HasForm(currentSpace as form) || _SHOblivionCells.HasForm(playerCell as form)

        ;if(isInOblivion && !wasInOblivion)
        ;    wasInOblivion = true
        ;    if(FirstPersonMessages)
        ;        _SHOblivionMessageFirst.Show()
        ;    else
        ;        _SHOblivionMessage.Show()
        ;    endif
        ;endif

        if(InOblivion)
            isInOblivion = true
            if(FirstPersonMessages)
                _SHOblivionMessageFirst.Show()
            else
                _SHOblivionMessage.Show()
            endif
        endif

        ;if(!isInOblivion && wasInOblivion)
        ;    wasInOblivion = false
        ;    if(FirstPersonMessages)
        ;        _SHOblivionBackFirst.Show()
        ;    else
        ;        _SHOblivionBack.Show()
        ;    endif
        ;endif
        
        if(!InOblivion)
            if(FirstPersonMessages)
                _SHOblivionBackFirst.Show()
            else
                _SHOblivionBack.Show()
            endif
        endif

    endif

EndFunction

;----------------------LEVELED LISTS FUNCTIONS--------------
function AddDrinksAndOthersToList()

    if(LLItemsAdded == false)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 3)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 3)
        LItemFoodInnCommon.AddForm(_SHWaterBottleMead, 1, 3)

        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 1)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 2)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 3)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 3)
        LItemFoodInnCommon.AddForm(_SHWaterBottleWine, 1, 3)

        LItemBarrelFoodSame75.AddForm(_SHMeadEmptyMisc, 1, 1)
        LItemBarrelFoodSame75.AddForm(_SHWineEmptyMisc, 1, 1)

        LootBanditRandom.AddForm(_SHLLWater25, 1 , 2)
        LootBanditRandom.AddForm(_SHLLWaterSkin15, 1, 1)
        LootBanditRandomWizard.AddForm(_SHLLWater25, 1 , 2)
        LootBanditRandomWizard.AddForm(_SHLLWaterSkin15, 1, 1)
        DLC2LootBanditRandom.AddForm(_SHLLWater25, 1 , 2)
        DLC2LootBanditRandom.AddForm(_SHLLWaterSkin15, 1, 1)
        DLC2LootBanditRandomWizard.AddForm(_SHLLWater25, 1 , 2)
        DLC2LootBanditRandomWizard.AddForm(_SHLLWaterSkin15, 1, 1)

        LLItemsAdded = true
    EndIf
EndFunction

;Not sure if this should be used
function RemoveDrinksFromList()
    LItemFoodInnCommon.Revert()
    LItemBarrelFoodSame75.Revert()

    LootBanditRandom.Revert()
    LootBanditRandomWizard.Revert()
    DLC2LootBanditRandom.Revert()
    DLC2LootBanditRandomWizard.Revert()
EndFunction
;------------------------------END LL FUNCTIONS-------------



;---------------------------ANIMATION FUNCTIONS----------------------------
Function PlayDrinkAnimation()
        If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
            If Player.GetSitState() == 0
                ;Debug.SendAnimationEvent(Player, "idleDrinkingStandingStart")
                ;Utility.Wait(7.5)
                ;Player.PlayIdle(IdleStop_Loose)
                ;Utility.Wait(1.0)
            Else
                Game.ForceThirdPerson()
                Utility.Wait(1.0)
                Debug.SendAnimationEvent(Player, "ChairDrinkingStart")
                Utility.Wait(1.0)
                Game.ForceFirstPerson()
            EndIf
        Else
            If Player.GetSitState() == 0
                Debug.SendAnimationEvent(Player, "idleDrinkingStandingStart")
                Utility.Wait(7.5)
                Player.PlayIdle(IdleStop_Loose)
            Else
                Debug.SendAnimationEvent(Player, "ChairDrinkingStart")
            EndIf
        endif
EndFunction

Function PlayEatAnimation()
    If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
        if(Player.GetSitState() == 0)
            ;    Debug.SendAnimationEvent(Player, "idleEatingStandingStart")
            ;    Utility.Wait(7.0)
            ;    Player.PlayIdle(IdleStop_Loose)
        elseif(Player.GetSitState() == 3)
            Game.ForceThirdPerson()
            Utility.Wait(1.0)
            Debug.SendAnimationEvent(Player, "ChairEatingStart")
            Utility.Wait(1.0)
            Game.ForceFirstPerson()
        endif
    else
        if(Player.GetSitState() == 0)
            Debug.SendAnimationEvent(Player, "idleEatingStandingStart")
            Utility.Wait(7.0)
            Player.PlayIdle(IdleStop_Loose)
        elseif(Player.GetSitState() == 3)
            Debug.SendAnimationEvent(Player, "ChairEatingStart")
        endif
    endif

EndFunction

Function PlayFillAnimation(bool playFillSound = true)
    If (RefillAnims)
        If Utility.IsInMenuMode()
            Game.DisablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.01)
            Game.EnablePlayerControls(False, False, False, False, False, True)
            Utility.Wait(0.25)
        EndIf

        If Player.IsWeaponDrawn()
            If SKSEVersion > 0.0
                Player.SheatheWeapon()
                Utility.Wait(2)
            endif
        endif

        If Player.GetAnimationVariableInt("i1stPerson") as Int == 1
            Game.ForceThirdPerson()
            Utility.Wait(1.0)
            Player.PlayIdle(idlepickup_ground)
            Utility.Wait(1.0)

            if(playFillSound)
                _SHFillWaterM.Play(Player)
            endif

            Utility.Wait(1.0)

            Player.PlayIdle(IdleStop_Loose)
            Utility.Wait(1.0)
            Game.ForceFirstPerson()
        else
            Utility.Wait(1.0)
            Player.PlayIdle(idlepickup_ground)
            Utility.Wait(1.0)

            if(playFillSound)
                _SHFillWaterM.Play(Player)
            endif

            Utility.Wait(1.0)
            Player.PlayIdle(IdleStop_Loose)
            Utility.Wait(1.0)
        endif
    EndIf
EndFunction
;------------------------------END--------------------------------

Function SetWidgetPresetLocations(int IndexWidgetPreset)

    if(Orientation == 1)
        if(IndexWidgetPreset == 0)
            WidgetX = 200
            WidgetY = 45
        ElseIf (IndexWidgetPreset == 1)
            WidgetX = 1125
            WidgetY = 45
        ElseIf (IndexWidgetPreset == 2)
            WidgetX = 175
            WidgetY = 721
        ElseIf (IndexWidgetPreset == 3)
            WidgetX = 1175
            WidgetY = 721
        EndIf
    Else
        if(IndexWidgetPreset == 0)
            WidgetX = 20
            WidgetY = 165
        ElseIf (IndexWidgetPreset == 1)
            WidgetX = 1245
            WidgetY = 165
        ElseIf (IndexWidgetPreset == 2)
            WidgetX = 20
            WidgetY = 721
        ElseIf (IndexWidgetPreset == 3)
            WidgetX = 1245
            WidgetY = 721        
        EndIf
    endif
EndFunction


bool Function IsInSaltwater()

	if Player.GetWorldSpace() == Tamriel

		if Player.GetPositionY() > 104000.0
			Return True
		elseif Player.GetPositionY() > 86500.0 && Player.GetPositionX() < -10800.0
			Return True
		elseif Player.GetPositionY() > 50250.0 && Player.GetPositionX() > 109250.0
			Return True
		else
			Return False
		endif
		
	elseif DLC2SolstheimWorld != None && Player.GetWorldSpace() == DLC2SolstheimWorld
		if Player.GetPositionX() < 31070.0
			Return True
		elseif Player.GetPositionY() < 24385.0
			Return True
		elseif Player.GetPositionY() > 79100.0
			Return True
		elseif Player.GetPositionX() > 76350.0
			Return True	
		else
			Return False
		endif
		
	else
		Return False
	endif
endFunction

Function VampireChangeNeeds(int option)
    if(_SHEnabled.GetValue() == 1)
        if(Vampire)
            if(option == 1)

                StartThirst()
                StopFatigue()
                StopHunger()
                if(WellBeing.IsRunning())
                    WellBeing.StopWellBeing()
                endif

            Elseif(option == 2)           
                StopHunger()
                StartThirst()
                StartFatigue()
                if(WellBeing.IsRunning())
                    WellBeing.StopWellBeing()
                endif
            ElseIf (option == 3)
                StartFatigue()
                StartHunger()
                StartThirst()
                if(!WellBeing.IsRunning())
                    WellBeing.StartWellBeing()
                endif
            endif
        else
            if(option == 4)
                StartFatigue()
                StartHunger()
                StartThirst()
                if(!WellBeing.IsRunning())
                    WellBeing.StartWellBeing()
                endif
            endif
        endif
    endif
EndFunction

;Starts the needs
Function StartSystems()
    StartHunger()
    StartThirst()
    StartFatigue()
    StartWellBeing()
EndFunction

;Stops the needs
Function StopSystems()
    StopThirst()
    StopFatigue()
    StopHunger()
    StopWellBeing()
EndFunction

;Pause needs where they are
Function PauseNeeds()
    Thirst.PauseUpdates()
    Hunger.PauseUpdates()
    Fatigue.PauseUpdates()

    ;Update the timestamps so next update doesnt progress needs.
    UpdateAllTimeStamps()
EndFunction

;Start needs back up after pausing
Function ResumeNeeds()
    Thirst.ResumeUpdates()
    Hunger.ResumeUpdates()
    Fatigue.ResumeUpdates()
EndFunction

;Updates all time stamps to current time when called
Function UpdateAllTimeStamps()
    Hunger._SHHungerTimeStamp.SetValue(Utility.GetCurrentGameTime())
    Fatigue._SHFatigueTimeStamp.SetValue(Utility.GetCurrentGameTime())
    Thirst._SHThirstTimeStamp.SetValue(Utility.GetCurrentGameTime())
EndFunction

;Stop functions so that other scripts may access stop functions
Function StopThirst()
    Thirst.StopSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StopHunger()
    Hunger.StopSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StopFatigue()
    Fatigue.StopSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StopWellBeing()
    WellBeing.StopWellBeing()
EndFunction

Function StartFatigue()
    Fatigue.StartSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StartHunger()
    Hunger.StartSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StartThirst()
    Thirst.StartSystem()
    SendModEvent("_SH_UpdateWidget")
EndFunction

Function StartWellBeing()
    WellBeing.StartWellBeing()
EndFunction
