# -*- coding: utf-8 -*-
from __future__ import division
from otree.api import (
    Currency as c, currency_range, SubmissionMustFail, Submission
)
from . import views
from ._builtin import Bot

import random




class PlayerBot(Bot):
    """Bot that plays one round"""

    def play_round(self):
        yield views.Part_3
        yield views.Institution


        yield (views.Groupe,
               dict(groupe=random.randint(0, 6)))


        yield (views.SurveyPage,
               dict(groupe=random.randint(0, 6)))

        self.submit(views.SurveyPage, {'sex': random.randint(0, 1),
                                       'sisters_brothers': random.randint(0, 1),
                                       'student': random.randint(0, 1),
                                       'field_of_studies': random.randint(0, 7),
                                       'level_of_study': random.randint(0, 3),
                                       'couple': random.randint(0, 1),
                                       'previous_participation': random.randint(0, 1)})

    def validate_play(self):
        pass
