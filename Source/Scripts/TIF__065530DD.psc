;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__065530DD Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
    Game.GetPlayer().RemoveItem(Gold001, 20)

    int thirstVal = 40
    
    if(_SHMain._SH_PerkRank_Hydrated.GetValue() == 1)
        thirstVal = 44
    ElseIf (_SHMain._SH_PerkRank_Hydrated.GetValue() == 2)
        thirstVal = 48
    endif

    float perkModifier = 0.0
    if(_SHMain._SH_PerkRank_Connoisseur.GetValue() == 1)
        perkModifier = 0.1
    ElseIf (_SHMain._SH_PerkRank_Connoisseur.GetValue() == 2)
        perkModifier = 0.2
    endif

    if(!_SHMain.Vampire || _SHMain.VampireNeedsOption == 3)
        _SHMain.Thirst.DecreaseThirstLevel(thirstVal)
        _SHMain.Hunger.DecreaseHungerLevel(165 + (165 * perkModifier))
    endif

    _SHFoodEat.Play(Game.GetPlayer())
    _SHMain.PlayEatAnimation()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject property Gold001 auto
_SunHelmMain property _SHMain auto
Sound property _SHFoodEat auto