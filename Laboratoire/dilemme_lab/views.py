from otree.api import Currency as c, currency_range
from ._builtin import Page, WaitPage
from . import models


class Instruction(Page):
    pass


class Section(Page):
    pass


class Attente(Page):
    pass


class Part_1(Page):
    pass


class Type(Page):
    def vars_for_template(self):
        joueur = self.player
        return dict(
            mon_choix_conditionnel=joueur.choix_conditionnel,
        )


class Inconditionnel(Page):
    form_model = 'player'
    form_fields = ['choix_inconditionnel']


class Conditionnel(Page):
    form_model = 'player'
    form_fields = ['choix_conditionnel']


class Results(Page):
    def vars_for_template(self):
        joueur = self.player
        partenaire = joueur.other_player()
        Group = self.group
        return dict(
            mon_choix_inconditionnel=joueur.choix_inconditionnel,
            mon_choix_conditionnel=joueur.choix_conditionnel,
            autre_choix_inconditionnel=partenaire.choix_inconditionnel,
            autre_choix_conditionnel=partenaire.choix_conditionnel,
            Alea=Group.Alea
        )


class ResultsWaitPage(WaitPage):
#    after_all_players_arrive = 'set_payoffs'
    title_text = "Merci d'attendre"
    body_text = "Veuillez patienter, vos gains sont en cours de calcul."

    def after_all_players_arrive(self):
        self.group.set_payoffs()


class ShuffleWaitPage(WaitPage):
    wait_for_all_groups = True

    def after_all_players_arrive(self):
        self.subsession.do_my_shuffle()

    title_text = "Merci d'attendre"
    body_text = "Veuillez patienter pendant la création des groupes."


class MyWaitPage(WaitPage):
    title_text = "Merci d'attendre"
    body_text = "Veuillez patienter le temps que l'autre membre de votre paire fasse son choix."

page_sequence = [
    Instruction,
    Attente,
    ShuffleWaitPage,
    Inconditionnel,
    MyWaitPage,
    Section,
    Attente,
    Conditionnel,
    ResultsWaitPage,
    Results,
    Type,
    ]
