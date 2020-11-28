Scriptname _SHDiseaseScript extends ActiveMagicEffect

Message property DiseaseMessage auto
Message property DiseaseMessage1st auto
Spell property CurrentDiseaseSpell auto
Spell property NextDiseaseSpell auto
int property hoursToNextStage auto
bool property firstDisease auto

bool FoodPoison = false

_SunHelmMain property _SHMain auto

event OnEffectStart(Actor akTarget, Actor akCaster)
    
    if(CurrentDiseaseSpell == _SHMain._SHFoodPoisoningSpell)
        _SHMain.HasFoodPoison = true
        FoodPoison = true
    endif

    if(DiseaseMessage && DiseaseMessage1st)
        if(_SHMain.FirstPersonMessages)
            DiseaseMessage1st.Show()
        else
            DiseaseMessage.Show()
        endif
    endif

    if(hoursToNextStage && hoursToNextStage > 0)
        RegisterForSingleUpdateGameTime(hoursToNextStage as float)
    endif

    if(firstDisease)
        game.IncrementStat("Diseases Contracted", 1)
    endif
endevent

event OnEffectFinish(Actor akTarget, Actor akCaster)
    if(CurrentDiseaseSpell == _SHMain._SHFoodPoisoningSpell)
        _SHMain.HasFoodPoison = false
    endif

    akTarget.RemoveSpell(CurrentDiseaseSpell)

endevent

event OnUpdateGameTime()
    Actor target = self.GetTargetActor()
    self.Dispel()

    if !FoodPoison && target
        target.DoCombatSpellApply(NextDiseaseSpell, Game.GetPlayer())
    endif
endevent