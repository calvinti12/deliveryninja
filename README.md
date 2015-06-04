# deliveryservice
open source text-based anonymized delivery service


#### Forward

I've got no tests. I've got no views. I've barely got any config. 

But it's a start. 


###GETTING STARTED

1) Bundle install

2) Migrate and Seed that DB

3) Add necessary config stuff into a *.env file (more details on that later)

3) run $ foreman start


### Testing out what's already here

* Open up rails console and check out the sweet referral creation and referral
management stuff. 

* use curl to post to the one route that's set up:

``` 
curl -H "Content-Type: application/json" -X POST -d '{"phone":"333","msg":"hello world I am dog"}' http://localhost:5000/communication/receive
curl -H "Content-Type: application/json" -X POST -d '{"phone":"333","msg":"hello world I am dog"}' http://mighty-chamber-1443.herokuapp.com/communication/receive

```

...and check out the communications controller to see all the sweet and probably
super brittle case/switches to see what options are available.
