Scriptname _SHIsVampire extends ActiveMagicEffect

_SunHelmMain property _SHMain auto
int currentOption
bool property VampireBeast auto

FormList property _SHVampireBlood auto
Keyword Property Vampire auto

Potion property DLC1BloodPotion auto

Actor Player


Function VampireFeedNeeds()
    if(_SHMain.VampireNeedsOption == 1)
        if(_SHMain.Thirst.IsRunning())
            _SHMain.Thirst.DecreaseThirstLevel(100)
        endif
    Else
        if(_SHMain.Thirst.IsRunning())
            _SHMain.Thirst.DecreaseThirstLevel(100)
        endif
    endif

EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)   
    Player = akTarget

    if(VampireBeast)
        RegisterForAnimationEvent(akTarget, "KillMoveEnd")        
    EndIf
    
    currentOption = _SHMain.VampireNeedsOption
    _SHMain.Vampire = true
    _SHMain.VampireChangeNeeds(currentOption)    

    _SHMain.RemoveDiseases()
    
EndEvent

Event OnVampireFeed(Actor akTarget)
    VampireFeedNeeds()
EndEvent

;To detect blood potions
Event OnObjectEquipped(form akBaseObject, ObjectReference akReference)

    if(akBaseObject as potion)
        if(akBaseObject == DLC1BloodPotion || _SHVampireBlood.HasForm(akBaseObject))
            VampireFeedNeeds()
        endif
    endif
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    VampireFeedNeeds()
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(!VampireBeast && !Player.HasKeyword(Vampire))
        _SHMain.Vampire = false
        _SHMain.VampireChangeNeeds(4)
    endif

EndEvent