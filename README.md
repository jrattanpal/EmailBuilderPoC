## How to setup this component

- CreateLogMeIn developer account to make API calls to Go To Webinar API: https://developer.logmeininc.com/
- Setup oAuth client at https://developer.logmeininc.com/clients as per https://developer.goto.com/guides/HowTos/02_HOW_createClient/
- Get Client ID and Secret from the app
- In your Salesforce org, setup Auth Provider with following configuration
  - Using Client ID and Secret from LogMeIn
![Auth Provider](/assets/images/EmailBuilderPoC_AuthProvider.png)
- Use "Callback URL" from Auth Provider and add it to "Redirect URIs" in your LogMeIn oAuth Client app
- Create Named Credentials with following configuration
![Auth Provider](/assets/images/EmailBuilderPoC_NamedCredential.png)
- Add remote site for "https://api.getgo.com" to allow for callouts from Apex


More information, specific to GoToWebinar setup, can be found at https://salesforce.stackexchange.com/questions/252277/named-credential-for-gotowebinar-app-oauth-v2-0

- Push source code to the org for Custom Metadata Type for configuration, Apex Classes and LWCs

To complete setup for your app, you need accountKey to be able to make calls to GoToWebinar API. Use the following method to get your account key.
- Go to https://myaccount.logmeininc.com/
- Login with your Go To Webinar account where you will be creating your webinars
- Get account from URL like below where "################" = accountKey
  - https://admin.logmeininc.com/portal/#accounts/################/users?filterType=usertype
- Go to Custom Metadata Type
- Click "Manage Records" for EmailBuilderAppSetting
- Edit "accountKey" and enter above value in "GTWFieldValue"
- Save



## Using the app

- Select App Launcher and go to "Email templates" (/lightning/o/EmailTemplate/home)
  - Make sure Lightning Email Templates are configured for your org
- Create a new template
- Click "Edit in Builder"
- You should see "EmailBuilder Component" under "Custom" in the "Components" list on the left
- Drag and drop this component on the email template in the middle
- Once selected, you will see "Select Webinar" property on the right
- If all is configured properly (i.e. oAuth Provider, Named Credentials etc) then you should list of webinars from the associated account (based on the accountKey you stored in Custom Metadata Type in previous steps)
  - If you see "invalidToken" next time then you will need to
    - Go to Named Credential
    - Click Edit
    - Click Save
  - This should re-authenticate you to your webinar account
  - In most cases, this step of re-authentication based on refresh_token is taken care of by Salesforce. However, because of slightly different implementatin of refresh token in LogMeIn oAuth Client, this needs to be done manually.

