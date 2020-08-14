from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants


class Part_2(Page):
    def is_displayed(self):
        return self.round_number == 1

    #def before_next_page(self):
    #    self.session.__init__()


class Instruction(Page):
    def is_displayed(self):
        return self.round_number == 1


class Attente(Page):
    def is_displayed(self):
        return self.round_number == 1


class Temp(Page):
    def vars_for_template(self):
        participant = self.participant
        return {
            'choix_conditionnel': participant.vars['choix_conditionnel'],
        }

    def before_next_page(self):
        self.subsession.rolee()
        self.player.role()
        self.subsession.affichage()
        self.group.donne()


class Info(Page):
    def is_displayed(self):
        return self.round_number == 1


class Contribution_W(Page):
    def is_displayed(self):
        return self.participant.vars['rolee'] == "Worker"

    form_model = 'player'
    form_fields = ['contribution','prediction_W_autre', 'prediction_W_seuil']

    #def vars_for_template(self) -> dict:
    #    return self.player.vars_for_template()


class Contribution_S(Page):
    def is_displayed(self):
        return self.participant.vars['rolee'] == "Supervisor"

    form_model = 'player'
    form_fields = ['seuil','prediction_S_puni']

    #def vars_for_template(self) -> dict:
    #    return self.player.vars_for_template()


class ResultsWaitPage(WaitPage):
    def after_all_players_arrive(self):
        self.group.set_payoffs()

        #if self.participant.vars['rolee'] == "Worker":
         #   self.p.autre()


        #for g in self.subsession.get_groups():
        #    g.set_payoffs()
        #    for p in g.get_players():
        #        p.autre()

    title_text = "Merci d'attendre"
    body_text = "Veuillez attendre la fin de cette période."


class Results(Page):
    """Players payoff: How much each has earned"""

    def before_next_page(self):
        if self.request.POST.get('back'):
            if self.request.POST.get('back')[0] == '1':
                self._is_frozen = False
                self._index_in_pages -= 2
                self.participant._index_in_pages -= 2


class ShuffleWaitPage(WaitPage):
    #wait_for_all_groups = True

    def after_all_players_arrive(self):
        self.subsession.do_my_shuffle()

    title_text = "Merci d'attendre"
    body_text = "Veuillez attendre votre groupe."


page_sequence = [
    Part_2,
    Instruction,
    Attente,
    ShuffleWaitPage,
    Temp,
    Info,
    Contribution_W,
    Contribution_S,
    ResultsWaitPage,
    Results,
]
