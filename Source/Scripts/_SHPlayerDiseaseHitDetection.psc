Scriptname _SHPlayerDiseaseHitDetection extends ReferenceAlias

;For use in the future disease module. This is not yet completed.

Actor property Player auto
bool locked = false

FormList property _SHDampWormRaces auto
FormList property _SHShakesRaces auto
FormList property _SHWitherRaces auto
FormList property _SHChillsRaces auto
FormList property _SHFeebleLimbRaces auto


spell property _SHDampWormSpell auto
spell property _SHShakesSpell auto
spell property _SHWitherSpell auto
spell property _SHChillsSpell auto
spell property _SHFeebleLimbSpell auto

GlobalVariable property _SHDiseases auto

_SunHelmMain property _SHMain auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

    if(_SHMain._SHEnabled.GetValue() == 1) 
        if akProjectile as Bool || !akAggressor as actor
            return 
        endIf

        if(_SHDiseases.GetValue())
            while locked
                utility.Wait(0.100000)
            endWhile
            
            locked = true
            CheckHitFormLists(akAggressor)
            locked = false
        endif
    endif
endevent

Function CheckHitFormLists(ObjectReference akAggressor)

    race enemyRace = (akAggressor as actor).GetLeveledActorBase().GetRace() as race
    if(_SHDampWormRaces.HasForm(enemyRace))
        Player.DoCombatSpellApply(_SHDampWormSpell, Player)
    ElseIf (_SHShakesRaces.HasForm(enemyRace))
        Player.DoCombatSpellApply(_SHShakesSpell, Player)
    ElseIf (_SHWitherRaces.HasForm(enemyRace))
        Player.DoCombatSpellApply(_SHWitherSpell, Player)
    ElseIf (_SHChillsRaces.HasForm(enemyRace))
        Player.DoCombatSpellApply(_SHChillsSpell, Player)
    ElseIf (_SHFeebleLimbRaces.HasForm(enemyRace))
        Player.DoCombatSpellApply(_SHFeebleLimbSpell, Player)
    endif

endfunction