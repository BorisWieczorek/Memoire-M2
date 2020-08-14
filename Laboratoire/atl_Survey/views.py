# -*- coding: utf-8 -*-
from __future__ import division

from otree.common import Currency as c, currency_range, safe_json

from . import models
from ._builtin import Page, WaitPage
from .models import Constants

class Part_3(Page):
    pass

class Institution(Page):
    pass
    #form_model = models.Player
    #form_fields = ['',]


class Groupe(Page):
    form_model = models.Player
    form_fields = ['groupe']




class SurveyPage(Page):
    form_model = models.Player
    form_fields = ['sex', 'sisters_brothers',
                   'student', 'field_of_studies',
                   'level_of_study', 'couple',
                   'previous_participation']


class MerciPage(Page):
    pass


page_sequence = [
    Part_3,
    #Institution,
    #Groupe,
    SurveyPage,
    #MerciPage
]
