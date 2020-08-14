from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)

import random
import numpy as np

doc = """
Dilemme du prisonnier unconditionnel et conditionnel pour récupérer les types
"""

class Constants(BaseConstants):
    name_in_url = 'dilemme_lab'
    players_per_group = 2
    num_rounds = 1

    #Gain en cas de stratégie identique
    double_cooperation = c(26)
    double_defection = c(20)

    #Gain en cas de stratégie opposée
    cooperation = c(0)
    defection = c(33)


class Subsession(BaseSubsession):

    def creating_session(self):
        for p in self.get_players():
            p.participant.vars['choix_conditionnel'] = []
            p.participant.vars['gain_1'] = 0

    def do_my_shuffle(self):
        self.group_randomly()

    def vars_for_admin_report(self):
        pass


class Group(BaseGroup):
    Alea = np.random.choice([1, 2], replace=True, p=[0.5, 0.5]) #nombre de puni

    def player_1(self):
        return self.get_player_by_id(1)

    def player_2(self):
        return self.get_player_by_id(2)

    def set_payoffs(self):
        if self.Alea == 1:
            for p in self.get_players():
                if p.id_in_group == 1:
                    p.perso = 'Lui'
                elif p.id_in_group == 2:
                    p.perso = "Moi"
                else:
                    p.perso = "personne"

                if self.player_1().choix_inconditionnel == 'option X':
                    if self.player_2().choix_conditionnel == 'option X':
                        if p.id_in_group == 1:
                            p.payoff = Constants.double_cooperation
                        elif p.id_in_group == 2:
                            p.payoff = Constants.double_cooperation
                        else:
                            p.payoff = '777'
                    elif self.player_2().choix_conditionnel == 'option Y':
                        if p.id_in_group == 1:
                            p.payoff = Constants.cooperation
                        elif p.id_in_group == 2:
                            p.payoff = Constants.defection
                        else:
                            p.payoff = '888'
                    else:
                        p.payoff = '000'
                elif self.player_1().choix_inconditionnel == 'option Y':
                    if self.player_2().choix_inconditionnel == 'option X':
                        if p.id_in_group == 1:
                            p.payoff = Constants.defection
                        elif p.id_in_group == 2:
                            p.payoff = Constants.cooperation
                        else:
                            p.payoff = '999'
                    elif self.player_2().choix_inconditionnel == 'option Y':
                        if p.id_in_group == 1:
                            p.payoff = Constants.double_defection
                        elif p.id_in_group == 2:
                            p.payoff = Constants.double_defection
                        else:
                            p.payoff = '101010'
                    else:
                        p.payoff = '111'
                else:
                    p.payoff = '222'
        elif self.Alea == 2:
            for p in self.get_players():
                if p.id_in_group == 2:
                    p.perso = 'Lui'
                elif p.id_in_group == 1:
                    p.perso = "Moi"
                else:
                    p.perso = "personne"

                if self.player_2().choix_inconditionnel == 'option X':
                    if self.player_1().choix_conditionnel == 'option X':
                        if p.id_in_group == 1:
                            p.payoff = Constants.double_cooperation
                        elif p.id_in_group == 2:
                            p.payoff = Constants.double_cooperation
                        else:
                            p.payoff = '111111'
                    elif self.player_1().choix_conditionnel == 'option Y':
                        if p.id_in_group == 1:
                            p.payoff = Constants.defection
                        elif p.id_in_group == 2:
                            p.payoff = Constants.cooperation
                        else:
                            p.payoff = '121212'
                    else:
                        p.payoff = '333'
                elif self.player_2().choix_inconditionnel == 'option Y':
                    if self.player_1().choix_inconditionnel == 'option X':
                        if p.id_in_group == 1:
                            p.payoff = Constants.cooperation
                        elif p.id_in_group == 2:
                            p.payoff = Constants.defection
                        else:
                            p.payoff = '131313'
                    elif self.player_1().choix_inconditionnel == 'option Y':
                        if p.id_in_group == 1:
                            p.payoff = Constants.double_defection
                        elif p.id_in_group == 2:
                            p.payoff = Constants.double_defection
                        else:
                            p.payoff = '141414'
                    else:
                        p.payoff = '444'
                else:
                    p.payoff = '555'
        else:
            for p in self.get_players():
                p.payoff = '666'

        for p in self.get_players():
            p.participant.vars['choix_conditionnel'] = p.choix_conditionnel
            p.participant.vars['gain_1'] = p.payoff
            if p.participant.vars['choix_conditionnel'] == 'option X':
                p.type = "Type X"
            elif p.participant.vars['choix_conditionnel'] == 'option Y':
                p.type = "Type Y"
            else:
                p.type = "erreur"



class Player(BasePlayer):
    choix_inconditionnel = models.StringField(
        choices=[['option X', 'option X'], ['option Y', 'option Y']],
        doc="""This player's decision""",
        widget=widgets.RadioSelect,
    )
    choix_conditionnel = models.StringField(
        choices=[['option X', 'option X'], ['option Y','option Y']],
        doc="""This player's decision""",
        widget=widgets.RadioSelect,
    )
    type = models.CharField(initial='')
    perso = models.CharField(initial='')

    def other_player(self):
        return self.get_others_in_group()[0]




