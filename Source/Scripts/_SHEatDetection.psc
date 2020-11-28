Scriptname _SHEatDetection extends ReferenceAlias

Actor Player
Form consumed

Keyword Property VendorItemFood Auto
Keyword Property _SHSaltWaterKeyword Auto

FormList Property _SHFoodLightList Auto
FormList Property _SHFoodMediumList Auto
FormList Property _SHFoodHeavyList Auto
FormList Property _SHSoupList auto
FormList Property _SHFoodIgnoreList Auto
FormList Property _SHRawList auto
FormList Property _SHDrinkList auto
FormList Property _SHMeadBottleList auto
FormList Property _SHAlcoholList auto
FormList Property _SHDrinkNoBottle auto


Message Property _SHUnknownFood Auto

import Utility

;(Refactor to use keywords instead of formlists) Use a formlist for unknown food
_SunHelmMain property _SHMain auto
_SHHungerSystem property _HungerSystem auto
_SHThirstSystem property _ThirstSystem auto

;Events

;Event fires when object is Equipped
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)
    If (akBaseObject as Potion)
        Player = Game.GetPlayer()
        consumed = akBaseObject
        FoodCheck()
    EndIf
EndEvent

;Functions

;Checks for food, and decreases if it is
Function FoodCheck()

    bool vampireHunger = false
    if(_SHMain.Vampire)
        if(_SHMain.VampireNeedsOption != 3)
            vampireHunger = true
        endif
    endif

    if(consumed.HasKeyword(_SHMain.VendorItemFoodRaw) || _SHRawList.HasForm(consumed))    
        ;Werewolfs in human form can eat raw meat
        if(!_SHMain.HumanWerewolf)
            if((_SHMain._SHRawDamage.GetValue() == 1) && !(Player.HasKeyword(_SHMain.IsBeastRace) || !Player.GetRace() == _SHMain.WoodElfRace) || !_SHMain.Vampire)              
                if(_SHMain._SHDiseasesEnabled.GetValue() == 1)
                    Player.DoCombatSpellApply(_SHMain._SHFoodPoisoningSpell,Player)
                else
                    Player.DamageActorValue("Health", (Utility.RandomInt(0,25)))
                endif
            endif
        endif

    EndIf

    float perkModifier = 0.0
    if(_SHMain._SH_PerkRank_Connoisseur.GetValue() == 1)
        perkModifier = 0.1
    ElseIf (_SHMain._SH_PerkRank_Connoisseur.GetValue() == 2)
        perkModifier = 0.2
    endif

    float foodPoisonModifier
    if(_SHMain.HasFoodPoison && _SHMain._SHDiseasesEnabled.GetValue() == 1)
        foodPoisonModifier = 0.75
    Else
        foodPoisonModifier = 1.00
    endif

    bool playAnim = false
    If (consumed.HasKeyword(_SHMain._SH_LightFoodKeyword) || _SHFoodLightList.HasForm(consumed))       
        if(!vampireHunger)
            _HungerSystem.DecreaseHungerLevel((40 + (40 * perkModifier)) * foodPoisonModifier)
            playAnim = true
        endif
    ElseIf(consumed.HasKeyword(_SHMain._SH_MediumFoodKeyword) || _SHFoodMediumList.HasForm(consumed))
        if(!vampireHunger)
            _HungerSystem.DecreaseHungerLevel((75 + (75 * perkModifier)) * foodPoisonModifier)
            playAnim = true
        endif
    ElseIf (consumed.HasKeyword(_SHMain._SH_HeavyFoodKeyword) || _SHFoodHeavyList.HasForm(consumed))
        if(!vampireHunger)
            _HungerSystem.DecreaseHungerLevel((125 + (125 * perkModifier)) * foodPoisonModifier)
            playAnim = true
        endif
    ElseIf (consumed.HasKeyword(_SHMain._SH_SoupKeyword) || _SHSoupList.HasForm(consumed))
        if(!vampireHunger)
            _HungerSystem.DecreaseHungerLevel(75 + (75 * perkModifier))
            _ThirstSystem.DecreaseThirstLevel(20 + (20 * perkModifier))
            playAnim = true
        endif
    ElseIf(_SHFoodIgnoreList.HasForm(consumed) || _SHDrinkList.HasForm(consumed) || _SHDrinkNoBottle.HasForm(consumed) || consumed.HasKeyword(_SHMain._SH_MeadWATERBottleKeyword) || consumed.HasKeyword(_SHMain._SH_SujammaWATERBottleKeyword) || consumed.HasKeyword(_SHMain._SH_WineWATERBottleKeyword) || _SHDrinkNoBottle.HasForm(consumed) || _SHAlcoholList.HasForm(consumed))
        return
    ElseIf (consumed.HasKeyword(VendorItemFood))
        
        int choice = _SHUnknownFood.Show()

        If (choice == 0)
            _SHFoodLightList.AddForm(consumed)
        ElseIf (choice == 1)
            _SHFoodMediumList.AddForm(consumed)
        ElseIf (choice == 2)
            _SHFoodHeavyList.AddForm(consumed)
        ElseIf (choice == 3)
            _SHSoupList.AddForm(consumed)
        ElseIf (choice == 4)
            _SHRawList.AddForm(consumed)
        ElseIf (choice == 5)
            _SHDrinkList.AddForm(consumed)
        ElseIf (choice == 6)
            _SHAlcoholList.AddForm(consumed)
            _SHMeadBottleList.AddForm(consumed)
        EndIf
    EndIf
    

    if(_SHMain.AnimationsEnabled && playAnim)
        _SHMain.PlayEatAnimation()
    endif
    return 
EndFunction