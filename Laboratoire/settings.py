from os import environ

# if you set a property in SESSION_CONFIG_DEFAULTS, it will be inherited by all configs
# in SESSION_CONFIGS, except those that explicitly override it.
# the session config can be accessed from methods in your apps as self.session.config,
# e.g. self.session.config['participation_fee']

SESSION_CONFIG_DEFAULTS = dict(
    real_world_currency_per_point=1.00, participation_fee=0.00, doc=""
)


SESSION_CONFIGS = [
    dict(
        name='Traitement_avec_information_bot',
        display_name="Traitement avec information bot",
        num_demo_participants=6,
        use_browser_bots=True,
        priorite=[2, 0, 3, 1],
        app_sequence=['bienvenue_lab', 'dilemme_lab',
                      'public_goods_1_lab', 'atl_Survey', 'payment_info_1_lab'],
    ),
    dict(
        name='Traitement_avec_information',
        display_name="Traitement avec information",
        num_demo_participants=6,
        priorite=[2, 0, 3, 1],
        app_sequence=['bienvenue_lab', 'dilemme_lab',
                      'public_goods_1_lab', 'atl_Survey', 'payment_info_1_lab'],
    ),
    dict(
        name='Traitement_sans_information_bot',
        display_name="Traitement sans information bot",
        num_demo_participants=6,
        use_browser_bots=True,
        priorite=[2, 0, 3, 1],
        app_sequence=['bienvenue_lab', 'dilemme_lab',
                      'public_goods_2_lab', 'atl_Survey', 'payment_info_1_lab'],
    ),
    dict(
        name='Traitement_sans_information',
        display_name="Traitement_sans_information",
        priorite=[2, 0, 3, 1],
        num_demo_participants=6,
        app_sequence=['bienvenue_lab', 'dilemme_lab',
                      'public_goods_2_lab', 'atl_Survey', 'payment_info_1_lab'],
    ),
    dict(
        name='bienvenue_lab',
        display_name="bienvenue",
        num_demo_participants=1,
        app_sequence=['bienvenue_lab', 'payment_info'],
    ),
    dict(
        name='dilemme_lab',
        display_name="dilemme",
        num_demo_participants=2,
        app_sequence=['dilemme_lab', 'payment_info'],
    ),
    dict(
        name='public_goods_1_lab',
        display_name="public goods 1 lab",
        num_demo_participants=6,
        priorite=[2, 0, 3, 1],
        app_sequence=['public_goods_1_lab', 'payment_info'],
    ),
    dict(
        name='atl_Survey',
        display_name='survey',
        num_demo_participants=1,
        app_sequence=['atl_Survey', 'payment_info'],
    ),
]

# ISO-639 code
# for example: de, fr, ja, ko, zh-hans
LANGUAGE_CODE = 'fr'

# e.g. EUR, GBP, CNY, JPY
REAL_WORLD_CURRENCY_CODE = 'USD'
USE_POINTS = True

ROOMS = [
    dict(
        name='econ101',
        display_name='Econ 101 class',
        participant_label_file='_rooms/econ101.txt',
    ),
    dict(name='live_demo', display_name='Room for live demo (no participant labels)'),
]

ADMIN_USERNAME = 'admin'
# for security, best to set admin password in an environment variable
ADMIN_PASSWORD = environ.get('OTREE_ADMIN_PASSWORD')

DEMO_PAGE_INTRO_HTML = """
Here are some oTree games.
"""

# don't share this with anybody.
SECRET_KEY = 'nogi(ymtn5fwe!h021e+hj1!r65d_e2c-+=34@=i+v6s0m^%w6'

