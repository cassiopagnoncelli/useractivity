Markov chain:

[Initial state] -> [Nutrition] -> [Sign up] -> [Sign in] -> [Free section] -> [Subscription] -> [Premium section]
[Initial state] -> [Sign in] -> [Free section] -> [Subscription] -> [Premium section], only if the user has SIGN_UP in its history.

Initial state:
- PAGE_VIEW (64.5%)
- CLICK_AD (35%)
- ACCEPT_INVITE (0.5%)

Nutrition (from any of Initial states):
- PASSWORD_RESET_REQUEST
- PASSWORD_CHANGE
- PROFILE_UPDATE
- LEAVE_REVIEW
- CONTACT_SUPPORT
- VIEW_HELP_FAQ
- DOWNLOAD_FILE
- ENABLE_NOTIFICATIONS
- DISABLE_NOTIFICATIONS
- INVITE_FRIEND
- SOCIAL_SHARE
- SUBSCRIBE_TO_NEWSLETTER
- UNSUBSCRIBE_FROM_NEWSLETTER

Sign up (from any of Nutrition states):
- SIGN_UP

Sign in (from Sign up state or, if already has SIGNUP in its history, any from
Initial State):
- SIGN_IN

Free section (from any of Sign in states):
- VIEW_ANALYTICS_DASHBOARD
- USE_FEATURE_A
- USE_FEATURE_B
- SHOW_PAYWALL
- CLOSE_PAYWALL
- APPLY_COUPON
- BOUNCE (8%)

Subscription (from any of Free states):
- SUBSCRIBE (8%)
- goes back to [Free Section] (92%)

Premium section (from any of Subscription states):
- USE_FEATURE_C (80%)
- USE_FEATURE_D (14%)
- USE_FEATURE_E (4%)
- UNSUBSCRIBE (2%)

It's organised in state groups to make it simpler.

A group of items are connected to another group of items according to the
diagram above, where [group A] -> [group B] means all items from group A are
connected to all items in group B (bipartite graph).

All items inside a group are connected to each other with equal weights
(complete graph inside the group).
