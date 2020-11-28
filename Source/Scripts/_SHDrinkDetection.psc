Scriptname _SHDrinkDetection extends ReferenceAlias

Actor Player
Form consumed

Keyword Property VendorItemFood Auto

FormList Property _SHMeadBottleList Auto
FormList Property _SHWineBottleList Auto
FormList Property _SHSujammaBottleList Auto
FormList Property _SHDrinkList auto
FormList Property _SHAlcoholList auto
FormList Property _SHDrinkNoBottle auto


Potion property _SHWaterBottleMead auto
Potion property _SHWaterBottleWine auto
Potion property _SHSaltBottleMead auto
Potion property _SHSaltBottleWine auto
Potion property _SHSujammaWaterBottle auto
Potion property _SHSaltBottleSujamma auto

MiscObject property _SHEmptyMeadMisc auto
MiscObject property _SHEmptyWineMisc auto
MiscObject property _SHEmptySujammaMisc auto
MiscObject property _SHWaterskin_Empty auto
Potion property _SHWaterskinSalt auto

Message Property _SHUnknownFood Auto

_SHThirstSystem property _ThirstSystem auto
_SunHelmMain property _SHMain auto

Potion property _SHWaterskin_1 auto
Potion property _SHWaterskin_2 auto
Potion property _SHWaterskin_3 auto

FormList property _SHWaterskins auto


import Utility


Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)

    if(akBaseObject as Potion)
        Player = Game.GetPlayer()
        consumed = akBaseObject
        DrinkCheck()
    endif

EndEvent

;This is kind of disgusting not gonna lie
Function DrinkCheck()

    int thirstVal = 40

    if(_SHMain._SH_PerkRank_Hydrated.GetValue() == 1)
        thirstVal = 44
    ElseIf (_SHMain._SH_PerkRank_Hydrated.GetValue() == 2)
        thirstVal = 48
    endif
  
    if (consumed == _SHSaltBottleMead)
        IncreaseThirst(20.00)
        ReturnBottle(0)

    ElseIf (consumed == _SHSaltBottleWine)
        IncreaseThirst(20.00)
        ReturnBottle(1)

    ElseIf (consumed == _SHSaltBottleSujamma)
        IncreaseThirst(20.0)
        ReturnBottle(2)

    ElseIf(consumed == _SHWaterskin_3)
        Player.AddItem(_SHWaterskin_2,1)
        DecreaseThirst(thirstVal)

    ElseIf (consumed == _SHWaterskin_2)
        Player.AddItem(_SHWaterskin_1,1)
        DecreaseThirst(thirstVal)

    ElseIf(consumed == _SHWaterskin_1)
        Player.AddItem(_SHWaterskin_Empty,1)
        DecreaseThirst(thirstVal)

    ElseIf (consumed == _SHWaterskinSalt)
        Player.AddItem(_SHWaterskin_Empty,1)
        IncreaseThirst(20.0)

    ElseIf (consumed.HasKeyword(_SHMain._SH_MeadWATERBottleKeyword) || _SHDrinkList.HasForm(consumed))

        if(_SHMain.AnimationsEnabled)
            _SHMain.PlayDrinkAnimation()
        endif
        DecreaseThirst(thirstVal)
        ReturnBottle(0)

    ElseIf (consumed.HasKeyword(_SHMain._SH_SujammaWATERBottleKeyword))

        if(_SHMain.AnimationsEnabled)
            _SHMain.PlayDrinkAnimation()
        endif
        DecreaseThirst(thirstVal)
        ReturnBottle(3)

    ElseIf (consumed.HasKeyword(_SHMain._SH_WineWATERBottleKeyword))

        if(_SHMain.AnimationsEnabled)
            _SHMain.PlayDrinkAnimation()
        endif
        DecreaseThirst(thirstVal)
        ReturnBottle(1)

    ElseIf (_SHDrinkNoBottle.HasForm(consumed) || consumed.HasKeyword(_SHMain._SH_DrinkKeyword))
        if(_SHMain.AnimationsEnabled)
            _SHMain.PlayDrinkAnimation()
        endif
        DecreaseThirst(thirstVal)

    ElseIf (consumed.HasKeyword(_SHMain._SHSaltWaterKeyword))
        if(_SHMain.AnimationsEnabled)
            _SHMain.PlayDrinkAnimation()
        endif
        IncreaseThirst(20.00)

    Elseif(consumed.HasKeyword(_SHMain._SH_MeadBottleKeyword) || _SHMeadBottleList.HasForm(consumed))
        ReturnBottle(0)
    ElseIf (consumed.HasKeyword(_SHMain._SH_WineBottleKeyword) || _SHWineBottleList.HasForm(consumed))
        ReturnBottle(1)
    ElseIf (consumed.HasKeyword(_SHMain._SH_SujammaBottleKeyword) || _SHSujammaBottleList.HasForm(consumed))
        ReturnBottle(2)
    endif
endFunction

Function ReturnBottle(int type)
    if(_SHMain.Bottles)
        if(type == 0)
            Player.AddItem(_SHEmptyMeadMisc,1)
        elseif(type == 1)
            Player.AddItem(_SHEmptyWineMisc,1)
        elseif(type == 2)
            Player.AddItem(_SHEmptySujammaMisc,1)
        endif
    endif
endFunction

Function DecreaseThirst(float amount)  
    if(!_SHMain.Vampire)
        if(_SHMain.VampireNeedsOption != 3)
            _ThirstSystem.DecreaseThirstLevel(amount)
        endif
    endif
EndFunction

Function IncreaseThirst(float amount)  
    if(!_SHMain.Vampire)
        if(_SHMain.VampireNeedsOption != 3)
            _ThirstSystem.IncreaseThirstLevel(amount)
        endif
    endif
EndFunction


