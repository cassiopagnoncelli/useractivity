#
# Source
#

# When a user visits any page.
PAGE_VIEW <- "PAGE_VIEW"

# When a user clicks on an advertisement.
CLICK_AD <- "CLICK_AD"

#
# Auth.
#

# When a user logs into the application.
SIGN_IN <- "SIGN_IN"

# When a user logs out of the application.
SIGN_OUT <- "SIGN_OUT"

# When a user creates a new account.
SIGN_UP <- "SIGN_UP"

#
# Account.
#

# When a user requests to reset their password.
PASSWORD_RESET_REQUEST <- "PASSWORD_RESET_REQUEST"

# When a user changes their password.
PASSWORD_CHANGE <- "PASSWORD_CHANGE"

# When a user updates their profile information.
PROFILE_UPDATE <- "PROFILE_UPDATE"

#
# Subscription.
#

# When a user applies a coupon code.
APPLY_COUPON <- "APPLY_COUPON"

# When a user subscribes to the application.
SUBSCRIBE <- "SUBSCRIBE"

# When a user cancels their subscription.
UNSUBSCRIBE <- "UNSUBSCRIBE"

# When a user renews their subscription.
RENEW_SUBSCRIPTION <- "RENEW_SUBSCRIPTION"

# When a user upgrades their subscription plan.
UPGRADE_SUBSCRIPTION <- "UPGRADE_SUBSCRIPTION"

# When a user downgrades their subscription plan.
DOWNGRADE_SUBSCRIPTION <- "DOWNGRADE_SUBSCRIPTION"

#
# Nurturing.
#

# When a user leaves a review or rating.
LEAVE_REVIEW <- "LEAVE_REVIEW"

# When a user contacts customer support.
CONTACT_SUPPORT <- "CONTACT_SUPPORT"

# When a user views the help or FAQ section.
VIEW_HELP_FAQ <- "VIEW_HELP_FAQ"

# When a user downloads a file.
DOWNLOAD_FILE <- "DOWNLOAD_FILE"

# When a user enables notifications.
ENABLE_NOTIFICATIONS <- "ENABLE_NOTIFICATIONS"

# When a user disables notifications.
DISABLE_NOTIFICATIONS <- "DISABLE_NOTIFICATIONS"

# When a user invites a friend to join the application.
INVITE_FRIEND <- "INVITE_FRIEND"

# When a user accepts an invitation to join the application.
ACCEPT_INVITE <- "ACCEPT_INVITE"

# When a user shares content on social media.
SOCIAL_SHARE <- "SOCIAL_SHARE"

# When a user subscribes to the newsletter.
SUBSCRIBE_TO_NEWSLETTER <- "SUBSCRIBE_TO_NEWSLETTER"

# When a user unsubscribes from the newsletter.
UNSUBSCRIBE_FROM_NEWSLETTER <- "UNSUBSCRIBE_FROM_NEWSLETTER"

# When a user views their analytics or dashboard.
VIEW_ANALYTICS_DASHBOARD <- "VIEW_ANALYTICS_DASHBOARD"

# When a paywall is shown to the user.
SHOW_PAYWALL <- "SHOW_PAYWALL"

# When a user closes the paywall.
CLOSE_PAYWALL <- "CLOSE_PAYWALL"

# When a user uses Feature A.
USE_FEATURE_A <- "USE_FEATURE_A"

# When a user uses Feature B.
USE_FEATURE_B <- "USE_FEATURE_B"

# When a user uses Feature C.
USE_FEATURE_C <- "USE_FEATURE_C"

# When a user uses Feature D.
USE_FEATURE_D <- "USE_FEATURE_D"

# When a user uses Feature E.
USE_FEATURE_E <- "USE_FEATURE_E"

# Array of all actions
ACTIONS <- c(
  PAGE_VIEW, CLICK_AD, SIGN_IN, SIGN_OUT, SIGN_UP, PASSWORD_RESET_REQUEST,
  PASSWORD_CHANGE, PROFILE_UPDATE, SEARCH, VIEW_ITEM, SUBSCRIBE, UNSUBSCRIBE,
  RENEW_SUBSCRIPTION, UPGRADE_SUBSCRIPTION, DOWNGRADE_SUBSCRIPTION,
  LEAVE_REVIEW, CONTACT_SUPPORT, VIEW_HELP_FAQ, DOWNLOAD_FILE, UPLOAD_FILE,
  ENABLE_NOTIFICATIONS, DISABLE_NOTIFICATIONS, INVITE_FRIEND, ACCEPT_INVITE,
  SOCIAL_SHARE, APPLY_COUPON, SUBSCRIBE_TO_NEWSLETTER,
  UNSUBSCRIBE_FROM_NEWSLETTER, VIEW_ANALYTICS_DASHBOARD, SHOW_PAYWALL,
  CLOSE_PAYWALL, USE_FEATURE_A, USE_FEATURE_B, USE_FEATURE_C, USE_FEATURE_D,
  USE_FEATURE_E
)
