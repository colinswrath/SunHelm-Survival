Scriptname _SHOblivionScript extends ActiveMagicEffect

_SunHelmMain Property _SHMain Auto
bool wasPaused = false

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if(_SHMain.pauseNeedsInOblivion)
        wasPaused = true
        _SHMain.CheckPlayerIsInOblivion(true)
    endif

endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if(wasPaused)
        wasPaused = false
        ;Reenable needs
        _SHMain.CheckPlayerIsInOblivion(false)
    endif

endEvent
