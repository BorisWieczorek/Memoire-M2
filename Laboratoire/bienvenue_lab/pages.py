from ._builtin import Page, WaitPage
from otree.api import Currency as c, currency_range
from .models import Constants



class Bienvenue_montp(Page):
    pass

class Introduction(Page):
    """Description of the game: How to play and returns expected"""
    pass

class Part_1(Page):
    pass

class Attente(Page):
    pass



page_sequence = [
    Bienvenue_montp,
    Introduction,
    Attente,
    Part_1,
]
