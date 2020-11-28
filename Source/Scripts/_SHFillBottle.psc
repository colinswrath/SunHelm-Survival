ScriptName _SHFillBottle extends ObjectReference 

Potion property FilledBottleName auto
Potion property SaltWaterBottle auto
MiscObject property EmptyBottle auto
_SunHelmMain property _SHMain auto

Actor Player


Event OnEquipped(Actor akActor)
    
    if(_SHMain.InWater)
        Player = Game.GetPlayer()
        Player.RemoveItem(EmptyBottle,1)
        _SHMain.PlayFillAnimation()
        ;Fresh Water
        if(!_SHMain.IsInSaltwater())
            Player.AddItem(FilledBottleName, 1)
        ;Saltwater
        Else         
            Player.AddItem(SaltWaterBottle, 1)
        endif
    Else
        if(_SHMain.FirstPersonMessages)
            _SHMain._SHStandWaterFirst.Show()
        Else
            _SHMain._SHStandWater.Show()
        endif
    endif

EndEvent

