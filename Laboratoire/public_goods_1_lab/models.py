from otree.api import (
    models, widgets, BaseConstants, BaseSubsession, BaseGroup, BasePlayer,
    Currency as c, currency_range
)
from django.conf import settings
import random
import numpy as np

doc = """
Jeu de bien public 1
"""


class Constants(BaseConstants):
    name_in_url = 'public_goods_1_lab'
    players_per_group = 3
    num_rounds = 2

    instructions_template = 'public_goods_1_lab/instructions.html'
    interface_contribute_template = 'public_goods_1_lab/interface_contribute.html'
    historique_W_template = 'public_goods_1_lab/Historique_W.html'
    historique_S_template = 'public_goods_1_lab/Historique_S.html'

    # """Amount allocated to each player"""
    endowment = c(20) #nombre de jeton disponible
    multiplier_A = 1 #multiplicateur du compte privé
    multiplier_B = 0.65 #multiplicateur du compte collectif
    multiplier_P = 1.5 #multiplicateur de punition
    initial = 0 #allocation de départ

    Treatment = 1 #traitement à information complète

    #pour les groupes
    X_X = 0
    X_Y = 1
    Y_Y = 2
    Y_X = 3


class Subsession(BaseSubsession):

    def creating_session(self):
        self.session.vars['Total_contributionT'] = []
        self.session.vars['UrnBT'] = []
        self.session.vars['InitialT'] = Constants.initial
        self.session.vars['Player'] = Constants.players_per_group
        self.session.vars['Round'] = Constants.num_rounds
        for p in self.get_players():
            p.participant.vars['ContributionT'] = 0
            p.participant.vars['UrnAT'] = 0
            p.participant.vars['TotalT'] = 0
            p.participant.vars['rolee'] = ''
            p.participant.vars['gain_2'] = 0

    def rolee(self):
        for p in self.get_players():
            if p.id_in_group == 1 or p.id_in_group == 2:
                p.participant.vars['rolee']='Worker'
            if p.id_in_group == 3:
                p.participant.vars['rolee']='Supervisor'



    def do_my_shuffle(self):
        if self.round_number == 1:

            players = self.get_players()

            X_players = [p for p in players if p.participant.vars['choix_conditionnel'] == 'option X']
            Y_players = [p for p in players if p.participant.vars['choix_conditionnel'] == 'option Y']

            print(X_players)
            print(Y_players)

            group_matrix = []

            priorites = self.session.config["priorite"]

            def is_possible(type_groupe, X_players, Y_players):
                if type_groupe == Constants.X_X:
                    return len(X_players) >= 3
                elif type_groupe == Constants.X_Y:
                    return len(X_players) >= 2 and len(Y_players) >= 1
                elif type_groupe == Constants.Y_Y:
                    return len(Y_players) >= 3
                elif type_groupe == Constants.Y_X:
                    return len(Y_players) >= 2 and len(X_players) >= 1
                return False

            for p in priorites:
                if p == Constants.X_X:
                    while is_possible(p, X_players, Y_players):
                        group_matrix.append([X_players.pop() for _ in range(3)])
                        print(group_matrix)

                if p == Constants.X_Y:
                    while is_possible(p, X_players, Y_players):
                        members = [X_players.pop() for _ in range(2)]
                        members.append(Y_players.pop())
                        group_matrix.append(members)
                        print(group_matrix)

                if p == Constants.Y_Y:
                    while is_possible(p, X_players, Y_players):
                        group_matrix.append([Y_players.pop() for _ in range(3)])
                        print(group_matrix)

                if p == Constants.Y_X:
                    while is_possible(p, X_players, Y_players):
                        members = [Y_players.pop() for _ in range(2)]
                        members.append(X_players.pop())
                        group_matrix.append(members)
                        print(group_matrix)

            self.set_group_matrix(group_matrix)
        else:
            self.group_like_round(1)

    def affichage(self):
        for p in self.get_players():
            if p.participant.vars['rolee'] == 'Worker':
                p.template_type ='public_goods_1_lab/type_W.html'
                p.template_result = 'public_goods_1_lab/result_W.html'
            elif p.participant.vars['rolee'] == 'Supervisor':
                p.template_type ='public_goods_1_lab/type_S.html'
                p.template_result = 'public_goods_1_lab/result_S.html'

    def vars_for_admin_report(self):
        contributions = [p.contribution for p in self.get_players() if p.contribution != None]
        if contributions:
            return {
                'avg_contribution': sum(contributions)/len(contributions),
                'min_contribution': min(contributions),
                'max_contribution': max(contributions),
            }
        else:
            return {
                'avg_contribution': '(no data)',
                'min_contribution': '(no data)',
                'max_contribution': '(no data)',
            }


class Group(BaseGroup):
    total_contribution = models.CurrencyField(initial=0)
    urnB = models.CurrencyField()
    seuil_info = models.CurrencyField()
    puni = models.IntegerField(initial=0) #nombre de puni
    piece = models.IntegerField(initial=2) #nombre de piece de punition disponible
    type_W = models.CharField(initial='')
    type_S = models.CharField(initial='')

    def player_1(self):
        return self.get_player_by_id(1)

    def player_2(self):
        return self.get_player_by_id(2)

    def player_3(self):
        return self.get_player_by_id(3)

    def donne(self):
        for p in self.get_players():
            if p.participant.vars['choix_conditionnel'] == 'option X':
                p.type = "Type X"
            elif p.participant.vars['choix_conditionnel'] == 'option Y':
                p.type = "Type Y"
            else:
                p.type = "erreur"

        self.type_W = self.player_1().type

        self.type_S = self.player_3().type

    def set_payoffs(self):

        #for p in self.subsession.get_groups():
            for p in self.get_players():
                self.total_contribution = self.player_1().contribution + self.player_2().contribution

                if p.participant.vars['rolee'] == 'Worker':
                    p.urnA = (Constants.endowment - p.contribution)*Constants.multiplier_A
                    p.autre_contri = self.total_contribution - p.contribution

            self.urnB = (self.total_contribution * Constants.multiplier_B)
            self.seuil_info = self.get_player_by_id(3).seuil


        #for w in self.subsession.get_groups():
            for w in self.get_players():
                if w.participant.vars['rolee'] == 'Worker' and w.contribution < self.seuil_info:
                    w.punition = 3
                    self.puni = self.puni+1
                    self.piece = self.piece-1
                elif w.participant.vars['rolee'] == 'Worker' and w.contribution >= self.seuil_info:
                    w.punition = 0

                if w.participant.vars['rolee'] == 'Worker':
                    w.payoff = Constants.initial + w.urnA + self.urnB - w.punition
                elif w.participant.vars['rolee'] == 'Supervisor':
                    w.payoff = Constants.initial + self.urnB + self.piece

                if w.payoff < 0:
                    w.payoff = 0

                w.participant.vars['gain_2'] = w.payoff + w.participant.vars['gain_2']
                #w.cumulative_payoff = sum([p.payoff for p in self.in_previous_rounds()]) + w.payoff


class Player(BasePlayer):
    template_result = models.CharField(initial='')
    template_type = models.CharField(initial='')
    type = models.CharField(initial='')
    contribution = models.IntegerField(
       min=0, max=Constants.endowment,
        doc="""The amount contributed by the player""",
    )
    seuil = models.IntegerField(
        choices=[0, 5, 10, 15, 20],
    )
    prediction_W_autre = models.IntegerField(
       min=0, max=Constants.endowment,
        doc="""The amount contributed by the player""",
    )
    prediction_W_seuil = models.IntegerField(
        choices=[(0,'0'),
                 (1, '5'),
                 (2, '10'),
                 (3, '15'),
                 (4, '20')],
    )
    prediction_S_puni = models.IntegerField(
        choices=[0, 1, 2],
    )
    urnA = models.CurrencyField(
    )
    punition = models.CurrencyField(initial=0,
    )
    cumulative_payoff = models.CurrencyField(
    )
    autre_contri = models.CurrencyField(
    )

    #def autre(self):
    #    if self.participant.vars['rolee'] == "Worker":
    #        for p in self.get_players():
    #            self.autre_contri = p.group.total_contribution - self.contribution

    def role(self):
        if self.id_in_group == 1:
            return 'Worker'
        if self.id_in_group == 2:
            return 'Worker'
        if self.id_in_group == 3:
            return 'Supervisor'

    #def vars_for_template(self):
            #        return dict(
            #   monnaie=settings.POINTS_CUSTOM_NAME,
            #   nb_others=Constants.players_per_group - 1,
            #   exemple_1=dict(contribution=5, gain=c(5 * Constants.token_private)),
            #   exemple_2=dict(contributions=[2, 3, 0, 7], total=12,
            #                  gain=c((2+3+0+7) * Constants.token_shared)),
            #   exemple_3=dict(
            #       contributions=[13, 3, 8, 5], keep=7, total=29, gain_cpte_indiv=c(7*Constants.token_private),
            #       gain_cpte_coll=c(29*Constants.token_shared),
            #       gain_total=c(7*Constants.token_private + 29*Constants.token_shared)),
            #   conversion=c(10).to_real_world_currency(self.session)
            #)
