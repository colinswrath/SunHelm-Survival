Scriptname _SHWerewolfScript extends activemagiceffect 

Bool property HumanWerewolf auto
Bool property BeastWerewolf auto
bool NeedsWerePaused = false

Perk property WerewolfFeedPerk auto

_SunHelmMain property _SHMain auto

Actor Player

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Player = akTarget

    _SHMain.RemoveDiseases()

    if(HumanWerewolf)
        _SHMain.HumanWerewolf = true
        ;Debug.Notification("PLAYER HUMAN WEREWOLF")

    ElseIf (BeastWerewolf)

        ;Pause werewolf needs
        if(_SHMain.WerewolfPauseNeeds)
            _SHMain.PauseNeeds()
            NeedsWerePaused = true
        EndIf

        ;Add perk and set bools
        Player.AddPerk(WerewolfFeedPerk)
        _SHMain.BeastWerewolf = true
        _SHMain.HumanWerewolf = false
    EndIf

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if(HumanWerewolf)
        _SHMain.HumanWerewolf = false
        ;Debug.Notification("PLAYER HUMAN WEREWOLF")

    ElseIf (BeastWerewolf)

        ;Unpause werewolf needs
        if(NeedsWerePaused)
            _SHMain.ResumeNeeds()
            NeedsWerePaused = false
        EndIf
      
        ;If set, decrease fatigue
        if(_SHMain.WerewolfFatigue)
            _SHMain.Fatigue.DecreaseFatigueLevel(100)
        EndIf
        
        ;Set bools and remove perk
        Player.RemovePerk(WerewolfFeedPerk)
        _SHMain.BeastWerewolf = false
        _SHMain.HumanWerewolf = true     
    EndIf

EndEvent