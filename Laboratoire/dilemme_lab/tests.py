# -*- coding: utf-8 -*-
from __future__ import division
from otree.api import (
    Currency as c, currency_range, SubmissionMustFail, Submission
)
from . import views
from ._builtin import Bot
from .models import Constants

import random


class PlayerBot(Bot):

    def play_round(self):
        yield views.Instruction
        yield Submission(views.Attente, check_html=False)

        choix=['option X', 'option Y']
        yield (views.Inconditionnel,
               dict(choix_inconditionnel=random.choice(choix)))

        yield views.Section
        yield Submission(views.Attente, check_html=False)

        yield (views.Conditionnel,
               dict(choix_conditionnel=random.choice(choix)))

        yield views.Results
        yield views.Type



