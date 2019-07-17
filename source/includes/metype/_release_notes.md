# Release Notes

## 20 Jun 2019 Release Note - Metype
1. Claps - Introducing the Claps widget. Available as an embed code, this widget lets your audience appreciate your content by applauding. 

![Claps](../../images/Metype_Claps.png "Claps")
![Claps Embed code](../../images/Metype_Claps_Embed_Code.png "Claps Embed Code")
![Claps Config Headline](../../images/Metype_Claps_Config_Headline.png "Claps Config Headline")

2. [Bug fix] - Unable to save Settings in config page.


## 14 Jun 2019 Release Note - Metype
1. Caching optimisations in Page Reactions widget.

## 10 Jun 2019 Release Note - Metype

1. Third Party Login enhancements
2. Removed page_url parameter from Live Feed iframe.
3. [Bug fix] - Login using Twitter and LinkedIn fails in LiveFeed widget.

## 31 May 2019 Release Note - Metype

1. Metype is now available for $7.99 per month. 
2. Android and iOS applications can now leverage the Third Party Login feature for commenting.
3. [Bug fix] - Facebook login redirect issue in iOS/Mac-Safari.

## 20 May 2019 Release Note - Metype
1. **Configurable Page Reaction Headline** - Now customize your own message to be displayed above the Page Reactions widget.
![Config - Configuarable Page Reaction Headline](../../images/Metype_Page_Reaction_Headline.png "Config - Configuarable Page Reaction Headline")

## 22 Apr 2019 Release Note - Metype
1. **Third party login with Metype:** Publishers and bloggers can use their own user login system to allow their audience to login and comment.

The developer documentation to implement this is available [here.](#third-party-login)

![Config - Third Party Login](../../images/Metype_ThirdPartyLogin.png "Config - Third Party Login") 

## 22 Oct 2018 Release Notes - Metype

1. Toggle to control display of Top Stories on Commenting Widget.

![Config - Top Pages](../../images/Metype_Top_Pages_Config.png "Config - Top Pages")

## 18 Oct 2018 Release Notes - Metype

1. **Top Pages on Commenting and Feed widget:** This section is visible on the Commenting and Feed widgets.
Top pages are the ones that have the most engagement with audiences. The set of top pages is refreshed every 4 hours. Also, newly published pages always stand a greater chance of being picked up as a top page.
![Comment Top Pages](../../images/Metype_Comment_Top_Pages.png "Comment Top Pages")
![Feed Top Pages](../../images/Metype_Feed_Top_Pages.png "Feed Top Pages")

2. **Perspective API for toxicity:** Moderate hate speech and inappropriate comments using the toxicity score. Filter by Toxicity and moderate in bulk with ease.
Check out our blog for more [here.](https://www.quintype.com/blog/tech/control-the-toxicity-of-comments-with-metype)

3. **Performance Optimisations:** Metype widgets are now optimised to load much quicker on your pages.

## 22 Aug 2018 Release Notes - Metype
1. **Enhanced Single Sign-On(SSO)** - Metype's SSO has been enhanced so users can sign-in with any email address and password.
The feature includes all login related workflows such as Sign-up, Sign-in and Forgot Password along with verification of email with an OTP.
The SSO login page also displays displays the website's branding.

[Click here](#single-sign-on-sso) to know how to integrate SSO on your website.

![Metype SSO Form Login](../../images/Metype_SSO_Form_Login.png "Metype SSO Form Login")
![Metype SSO Form Sign Up](../../images/Metype_SSO_Form_Signup.png "Metype SSO Form Sign Up")
![Metype SSO Form OTP](../../images/Metype_SSO_Form_OTP.png "Metype SSO Form OTP")
![Metype SSO Form Authenticate User](../../images/Metype_SSO_Form_Authenticate_User.png "Metype SSO Form Authenticate User")

2. [Bug fix] Ad-units not responsive.
3. [Bug fix] Twitter and LinkedIn Login redirect issues in SSO.


## 13 Aug 2018 Release Notes - Metype

1. [Bug fix] Commenting widget was partially loaded on pages part of a set of infinite scroll stories.


## 3 Aug 2018 Release Notes - Metype

1. Sign-in to Metype using your LinkedIn account. This is available on Metype home page, Comment widget sign-in, Feed widget sign-in and also available to publishers using Metype login to manage their user identities.
![Metype LinkedIn Sign In](../../images/Metype_LinkedIn_SSO_SignIn.png "Metype LinkedIn Sign In")
![Metype LinkedIn Sign In Home](../../images/Metype_LinkedIn_Home_SignIn.png "Metype LinkedIn Sign In Home")
![Metype LinkedIn Sign In Feed](../../images/Metype_LinkedIn_Feed_SignIn.png "Metype LinkedIn Sign In Feed")


![Metype LinkedIn Sign In Comment](../../images/Metype_LinkedIn_Comment_SignIn.png "Metype LinkedIn Sign In Comment")



## 27 Jul 2018 Release Notes - Metype

1. The Live Feed is now enhanced to allow users to login and view their notificaions.

![Feed Notifications Logged In](../../images/Notifications_on_Feed_In.png "Feed Notifications Logged in") ![Feed Notifications Logged Out](../../images/Notifications_on_Feed_Out.png "Feed Notifications Logged out")


## 26 Jul 2018 Release Notes - Metype

```shell
<div id='metype-container' class='iframe-container' data-metype-account-id='2' data-metype-host='https://www.metype.com/' data-metype-primary-color='#0000ff' data-metype-bg-color='#ffffff' data-metype-font-color='#4a4a4a'> data-metype-comment-widget-id="comment-widget-2"</div>
<script type='text/javascript'>
  var metypeContainer = document.getElementById("metype-container"),
    page_url = metypeContainer.getAttribute("data-metype-page-url");
  metypeContainer.setAttribute('data-metype-page-url', page_url || window.location.href);
  metypeContainer.setAttribute('data-metype-window-height', window.innerHeight);
  metypeContainer.setAttribute('data-metype-screen-width', window.screen.width);
  talktype(function() {
    talktype.commentWidgetIframe(metypeContainer);
  });
</script>
```
1. Publishers can now embed many conversations on a single page.


**Note to developers:** The commenting widget allows an additional field `data-metype-comment-widget-id` in the `<div>` tag of the commenting widget, and can have any arbitrary value. E.g.,
`data-metype-comment-widget-id="comment-widget-2"`.


## 4 Jul 2018 Release Notes - Metype

1. Notifications for reactions to comments - commenters will now get notified when other users react on their comments.
![Comment Reactions Notify](../../images/Comment_Reactions_4Jul18.png "Comment Reactions Notification")
2. Story Reactions - Publishers can now use Story Reactions to emote and engage with their audience without having to type in anything.
![Story Reactions](../../images/Story_Reactions_4Jul18.png "Story Reactions")
Write to us at metype@quintype.com to get your own set of story reactions configured for your account.
3. Bug fixes and loading speed optimisations on the widgets.
