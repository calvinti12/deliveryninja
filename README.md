## deliveryservice

### What is this? 

DeliveryNinja is an extremely low-cost, open-source platform for validating delivery-based business models via anonymized text-messaging. Underground delivery services are becoming increasingly common, whether they be for bento boxes, [cookies](http://www.northbynorthwestern.com/story/magazine-project-cookie-by-catherine-rolfe/), [sandwiches](http://www.northbynorthwestern.com/story/michael-wilbon-on-journalism-and-nus-mythic-sandwi/), or [more nefarious purposes](http://apps.northbynorthwestern.com/magazine/2015/spring/trailblazin/)

This app allows entrepreneurs to quickly and cheaply set up the infrastructure
necessary to test or operate a beta/MVP solely via text messaging.


This app also allows you to start with a closed beta by requiring referrals to start making orders. No need to create a website or payment processing.  

*Anonymized? What do you mean?*

Users and admins interact solely through the twilio number, so you don't expose your mobile phone number directly to the admins (and vice versa). Admins also have the ability to destroy all records with one command, in case they determine they want to shut down their market validation and remove all data. 


*What about having a menu? What about spreading the word?*

Not my problem. Go print your menu along with this twilio phone number on some quarter sheets. Or submit a PR with that feature. Be creative and cheap. 


### Ok, so how does it work? 

Let's assume that we have three users to start with: an admin, a person who
wants to be a new user, and a person who is already an existing user


- EXISTING USER COMMANDS
  - "get referral"
      (gives you a referral to give to someone else)
  - "5 cookies to 1 Wacker Dr" 
      (will send an admin your order and where it is to be delivered)
      admin will see a message like the following:
      ``` "Order #19  5 cookies to 1 Wacker Dr" ```
  - "remove me" (TODO)
      (remove this user and records from the system)

- NEW USER COMMANDS
   - "referral \<referral code\>"
     (consume a referral. If valid, you will be told if you are admitted or if you need more referrals)

- ADMIN COMMANDS
  - "nuke all" (todo) 
    (nuke everything)
  - "get referral"
    (generate a referral that, when used, will automatically admit the user that
     consumes it)
  - "close"
    (close yourself for business)
  - "open"
    (open yourself for business)
  - "reply #9 I'm here"
    (reply to user who submitted order 9 with the message "I'm here")

### What Can I configure and where?
    Currently, all config is in app/models/user/settings.rb. You can set.
    - How many referrals are required to gain admittance (including 0 for public beta)
    - Set a cap for how many referrals a user can create in the # of days specify
    - Specify the number of days 


#### A Brief Forward

I've got no tests. I've got no views. I've barely got any config. 

But it's a start. 


###GETTING STARTED LOCALLY

0) clone this repo

1) Bundle install

2) Migrate and Seed that DB

3) Add necessary config stuff into a *.env file (more details on that later)

4) run $ foreman start

### DEPLOY IN A FEW EASY STEPS! 

1) Create a twilio (and get a free number) and create a heroku account. 

2) Add the necessary twilio config to a .env file. See .env.example for the list
of necessary data. 

3) from the command line, create a heroku app with $ heroku create

4)Install config pusher
```$ heroku plugins:install git://github.com/ddollar/heroku-config.git 

5) run it!
```$ heroku config:push

6) push to heroku
``` $ git push heroku master

7) migrate that DB

``` heroku run rake db:migrate

8) Become an admin!

``` Text "get referral" to the twilio number from your phone. Poof, you are an admin! 

