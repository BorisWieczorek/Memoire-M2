from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants


class Results(Page):
    """Players payoff: How much each has earned"""
    def vars_for_template(self):
        # Set payoffs
        self.player.random_payoffs()
        self.group.gain()
        # Display
        participant = self.participant
        session = self.session
        return {
            'gain_1': participant.vars['gain_1'],
            'gain_2': participant.vars['gain_2'],
        }
    form_model = 'player'
    form_fields = [
        'commentaire',]



class PaymentInfo(Page):

    def vars_for_template(self):
        participant = self.participant
        return {
            'redemption_code': participant.label or participant.code,
        }



page_sequence = [Results,
                 PaymentInfo,
                ]
