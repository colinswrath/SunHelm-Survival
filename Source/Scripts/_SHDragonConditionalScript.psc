Scriptname _SHDragonConditionalScript extends ActiveMagicEffect

_SunHelmMain Property _SHMain Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	_SHMain.isRidingDragon = true
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	_SHMain.isRidingDragon = false

endEvent