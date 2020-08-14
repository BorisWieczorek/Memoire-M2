# -*- coding: utf-8 -*-
from __future__ import division
from otree.api import (
    Currency as c, currency_range, SubmissionMustFail, Submission
)
from . import pages
from ._builtin import Bot
from .models import Constants

import random




class PlayerBot(Bot):
    """Bot that plays one round"""

    def play_round(self):
        if self.player.round_number == 1:
            yield pages.Part_2
            yield pages.Instruction

            yield Submission(pages.Attente, check_html=False)

        yield pages.Temp

        if self.player.round_number == 1:
            yield pages.Info

        if self.participant.vars['rolee'] == "Worker":
            yield (pages.Contribution_W,
                   dict(contribution=random.randint(0, Constants.endowment),
                        prediction_W_autre=random.randint(0, Constants.endowment),
                        prediction_W_seuil=random.randint(0, 4)))


        if self.participant.vars['rolee'] == "Supervisor":
            yield (pages.Contribution_S,
                   dict(seuil=random.choice(0, 5, 10, 15, 20),
                        prediction_S_puni=random.randint(0, 2)))

        yield pages.Results