HackyTheMindFlexHeadset
=======================

So you have a Hacked Mind Flex Headset? and you want to trigger events online with it? Say "Hi" to Hacky! It uses a Processing Sketch to get your EEG data and stream it to Internet of Things platform Xively.com. From there, you can automate internet stuff with Zapier.com.      This code is based off https://github.com/kitschpatrol/Processing-Brain-Grapher and https://github.com/jmsaavedra/Cosm-Processing-Library. 


1) Hack your Mind Flex Headset. Go here FrontierNerds.com/BrainHack.
2) Set up an account at Xively.com, and make a feed.
3) Get your "FEED ID" and "API KEY"
4) In the code, replace 

    String apiKey = "API KEY HERE";

with your API KEY

5) In the code, replace

    String feedId = "FEED ID HERE";
    
with your feed ID.

6) Run the Sketch.



ISSUES:

If you run into a "Array overrun" error, you need to restart the sketch.


The sketch runs for 100 loops, but you can change that here by switching "100" to 
whatever you'd like:

      //take 100 readings and post to Xively
  for (int j=0;j<100;j++)
  


