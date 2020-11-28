Scriptname _SHWaterskinEquipScript extends ActiveMagicEffect

_SunHelmMain property _SHMain auto
Armor Property _SHWaterskinLeft Auto
Armor Property _SHWaterskinRight Auto
Armor Property _SHWaterskinBack Auto
Actor Player

Event OnEffectStart(Actor akTarget, Actor akCaster)
    
    Player = akTarget
    int skinPlace = _SHMain.WaterskinLocation

    if(skinPlace == 0)
        Player.AddItem(_SHWaterskinBack, 1, true)
		Player.EquipItem(_SHWaterskinBack, false, true)
    ElseIf (skinPlace == 1)
        Player.AddItem(_SHWaterskinRight, 1, true)
		Player.EquipItem(_SHWaterskinRight, false, true)
    ElseIf (skinPlace == 2)
        Player.AddItem(_SHWaterskinLeft, 1, true)
		Player.EquipItem(_SHWaterskinLeft, false, true)
    endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    Player.RemoveItem(_SHWaterskinBack, Player.GetItemCount(_SHWaterskinBack) as Int, true)
	Player.RemoveItem(_SHWaterskinRight, Player.GetItemCount(_SHWaterskinRight) as Int, true)
	Player.RemoveItem(_SHWaterskinLeft, Player.GetItemCount(_SHWaterskinLeft) as Int, true)
EndEvent
