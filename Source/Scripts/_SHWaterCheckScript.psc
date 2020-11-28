Scriptname _SHWaterCheckScript extends activemagiceffect 

_SunHelmMain property _SHMain auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    _SHMain.InWater = true
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    _SHMain.InWater = false
EndEvent
