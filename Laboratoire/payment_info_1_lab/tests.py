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
        yield pages.Results

        yield Submission(pages.PaymentInfo, check_html=False)