from otree.api import (
    Currency as c, currency_range, SubmissionMustFail, Submission
)
from . import pages
from ._builtin import Bot


class PlayerBot(Bot):

    def play_round(self):
        yield pages.Bienvenue_montp

        yield pages.Introduction

        yield Submission(pages.Attente, check_html=False)

        yield pages.Part_1

