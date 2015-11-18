import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
String searchString = "cat";
double lat = 41.826328;
double lon = -71.403276;
double res = 15;
String resUnit = "mi";
List<Status> tweets;

int currentTweet;

void setup()
{
  size(800,800);
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("u4nVQf1SUWU9KFT8qoqAHalrJ");
  cb.setOAuthConsumerSecret("OFXgh9fRQPkdsM3ImiMbn0zQQX4qWlh6eG4kgEEtt8pwI4XNYI");
  cb.setOAuthAccessToken("5568762-jl2Jttt5QTWrCHWbaIJ9JtoEE9cvrgM2ZHO3aIcCeQ");
  cb.setOAuthAccessTokenSecret("gqAsWjxdFwwNhLboOib8xB8yfXBlR8pWI4BHCMgRZdV05");
  
  TwitterFactory tf = new TwitterFactory(cb.build());
  
  twitter = tf.getInstance();
  
  getNewTweets();
  
  currentTweet = 0;
  
  thread("refreshTweets");
} 

void draw()
{
  fill(0, 40);
  rect(0, 0, width, height);
  
  currentTweet = currentTweet + 1;
  
  if (currentTweet >= tweets.size())
   {
     currentTweet = 0;
   }
   
   Status status = tweets.get(currentTweet);
   
   fill(200);
   text(status.getText(), random(width), random(height), 300, 200);
   
   delay(250);
  
}

void getNewTweets()
{
   try
   {

     //  " public static final Query.ResultType recent " should be somewhere here?
     

     Query query = new Query().geoCode(new GeoLocation(lat,lon), res, resUnit);
     

     QueryResult result = twitter.search(query);
     
     tweets = result.getTweets();
   }
   catch (TwitterException te)
   {
     System.out.println("Failed to search tweets: " + te.getMessage());
     System.exit(-1);
   }
   
}

void refreshTweets()
{
  while (true)
  {
     getNewTweets();
     
     println("Updated Tweets");
     
     delay(30000);
  }
}