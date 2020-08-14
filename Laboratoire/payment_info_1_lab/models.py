from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
import random
import numpy as np

doc = """
This application provides a webpage instructing participants how to get paid.
Examples are given for the lab and Amazon Mechanical Turk (AMT).
"""


class Constants(BaseConstants):
    name_in_url = 'payment_info_1_lab'
    players_per_group = None
    num_rounds = 1

class Subsession(BaseSubsession):
    pass


class Group(BaseGroup):
    def gain(self):
        for p in self.get_players():
            p.gain_1 = p.participant.vars['gain_1']
            p.gain_2 = p.participant.vars['gain_2']
            p.gain = p.participant.vars['gain_1'] + p.participant.vars['gain_2']
            p.gain_t = p.gain*0.1

class Player(BasePlayer):
    total_gain = models.CurrencyField()
    commentaire = models.LongStringField(blank=True,)
    gain = models.CurrencyField(
    )
    gain_1 = models.CurrencyField(
    )
    gain_2 = models.CurrencyField(
    )
    gain_t = models.CurrencyField(
    )


    def random_payoffs(self):
        self.total_gain = self.participant.payoff*0.1 + 1 + 3
