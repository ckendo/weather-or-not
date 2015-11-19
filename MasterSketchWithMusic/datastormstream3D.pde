/*
SimpleTwitterStreaming
 Developed by: Michael Zick Doherty
 2011-10-18
 http://neufuture.com
 */

///////////////////////////// Config your setup here! ////////////////////////////

class dataStorm extends DefaultSketch{
  // This is where you enter your Oauth info
  String OAuthConsumerKey = "u4nVQf1SUWU9KFT8qoqAHalrJ";
  String OAuthConsumerSecret = "OFXgh9fRQPkdsM3ImiMbn0zQQX4qWlh6eG4kgEEtt8pwI4XNYI";
  // This is where you enter your Access Token info
  String AccessToken = "5568762-jl2Jttt5QTWrCHWbaIJ9JtoEE9cvrgM2ZHO3aIcCeQ";
  String AccessTokenSecret = "gqAsWjxdFwwNhLboOib8xB8yfXBlR8pWI4BHCMgRZdV05";
  
  // if you enter keywords here it will filter, otherwise it will sample
  String keywords[] = {
  };
  
  ///////////////////////////// End Variable Config ////////////////////////////
  
  TwitterStream twitter = new TwitterStreamFactory().getInstance();
  PImage img;
  boolean imageLoaded;
  float t = 0;
  float tt = 1000;
  float g_time = 0;
  float g_time2 = 20;
  float g_time3 = 50;
  int cellsize = 3; // Dimensions of each cell in the grid
  int cols, rows;   // Number of columns and rows in our system
  
  //array
  PImage[] buffer = new PImage[5];
  int currentIndex = 1;
  
  dataStorm(){
  }
  
  //@Override
  void Setup() {
    //size(1600, 900, P3D);
    noStroke();
    imageMode(CENTER);
    connectTwitter();
    twitter.addListener(listener);
    if (keywords.length==0) twitter.sample();
    else twitter.filter(new FilterQuery().track(keywords));
        
  }
  
  void PlayAudio(){}
  void StopAudio(){}
  
  //@Override
  void Draw() {
  background(0);
    
  int rx = int(random(0, 50));
  int rh = int(random(0, 50));
  g_time += 0.01;
  g_time2 += 0.005;
  g_time3 += 0.005;
        
  noiseDetail(5,.5); 
  float noiseval2 = noise(g_time2 / 0.5, width / 50.0, height / 50.0);
  float noiseval3 = noise(g_time / 0.5, width / 50.0, height / 50.0);
  float noiseposX = map(noiseval2, 0, 1, 1, 900);
  float noiseposY = map(noiseval3, 0, 1, 1, 400);
         
        
   
  if (imageLoaded) {
    
     cols = img.width/cellsize;             // Calculate # of columns
    rows = img.height/cellsize;            // Calculate # of rows
  
    loadPixels();
        
    // Begin loop for columns
    for ( int i = 0; i < cols;i++) {
      // Begin loop for rows
      for ( int j = 0; j < rows;j++) {
        int x = i*cellsize + cellsize/2; // x position
        int y = j*cellsize + cellsize/2; // y position
        int loc = x + y*img.width;           // Pixel array location
        
       //positioning of rectangles
         float xpand = 0;
         xpand = xpand + 1;
        
         //noise stuff
       noiseDetail(5,.5);
          float noiseval = noise(g_time / 1.0, float (x) / 100.0, float (y) / 100.0);
          float noiseposZ = map(noiseval, 0, 1, 1, width);
         
          float noisealpha = map(noiseval, 0, 1, 0, 255);
       
          
        color c = img.pixels[(loc%img.pixels.length)];       // Grab the color
        float a = noisealpha;
        // Calculate a z position as a function of mouseX and pixel brightness //<>//
        float z = ((noiseposZ)*2/float (width)) * brightness(img.pixels[(loc%img.pixels.length)]) - (100.0);
        // Translate to the location, set fill and stroke, and draw the rect
        pushMatrix();
        translate(x,y,z);
        fill(c,a);
        noStroke();
        rectMode(CENTER);
        rect(noiseposX, noiseposY,cellsize,cellsize);
        popMatrix();
      }
    }
  
  }
  
  }
  
  // Initial connection
  void connectTwitter() {
    twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
    AccessToken accessToken = loadAccessToken();
    twitter.setOAuthAccessToken(accessToken);
  }
  
  // Loading up the access token
  private AccessToken loadAccessToken() {
    return new AccessToken(AccessToken, AccessTokenSecret);
  }
  
  // This listens for new tweet
  StatusListener listener = new StatusListener() {
    public void onStatus(Status status) {
  
      //println("@" + status.getUser().getScreenName() + " - " + status.getText());
  
      String imgUrl = null;
      String imgPage = null;
  
      // Checks for images posted using twitter API
  
      if (status.getMediaEntities() != null) {
        imgUrl= status.getMediaEntities()[0].getMediaURL().toString();
      }
      // Checks for images posted using other APIs
  
      else {
        if (status.getURLEntities().length > 0) {
          if (status.getURLEntities()[0].getExpandedURL() != null) {
            imgPage = status.getURLEntities()[0].getExpandedURL().toString();
          }
          else {
            if (status.getURLEntities()[0].getDisplayURL() != null) {
              imgPage = status.getURLEntities()[0].getDisplayURL().toString();
            }
          }
        }
  
        if (imgPage != null) imgUrl  = parseTwitterImg(imgPage);
      }
  
      if (imgUrl != null) {
  
        println("found image: " + imgUrl);
  
        // hacks to make image load correctly
  
        if (imgUrl.startsWith("//")){
          println("s3 weirdness");
          imgUrl = "http:" + imgUrl;
        }
        if (!imgUrl.endsWith(".jpg")) {
          byte[] imgBytes = loadBytes(imgUrl);
          saveBytes("tempImage.jpg", imgBytes);
          imgUrl = "tempImage.jpg";
        }
  //load int image obj
        println("loading " + imgUrl);
        if (loadImage(imgUrl) != null) {
        buffer[currentIndex] = loadImage(imgUrl);
        img = buffer[1];
        //img = buffer[(currentIndex) % buffer.length];
        currentIndex = (currentIndex + 1) % (buffer.length);
        imageLoaded = true;
        }
      }
    }
  
    public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      //System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
    }
    public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      //  System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
    }
    public void onScrubGeo(long userId, long upToStatusId) {
      System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }
  
    public void onException(Exception ex) {
      ex.printStackTrace();
    }
  };
  
  
  // Twitter doesn't recognize images from other sites as media, so must be parsed manually
  // You can add more services at the top if something is missing
  
  String parseTwitterImg(String pageUrl) {
  
    for (int i=0; i<imageService.length; i++) {
      if (pageUrl.startsWith(imageService[i][0])) {
  
        String fullPage = "";  // container for html
        String lines[] = loadStrings(pageUrl); // load html into an array, then move to container
        for (int j=0; j < lines.length; j++) { 
          fullPage += lines[j] + "\n";
        }
  
        String[] pieces = split(fullPage, imageService[i][1]);
        pieces = split(pieces[1], "\""); 
  
        return(pieces[0]);
      }
    }
    return(null);
  }
  
    // { site, parse token }
  String imageService[][] = { 
    { "http://yfrog.com",    "<meta property=\"og:image\" content=\""}, 
    {"http://twitpic.com",   "<img class=\"photo\" id=\"photo-display\" src=\""}, 
    {"http://img.ly",        "<img alt=\"\" id=\"the-image\" src=\"" }, 
    { "http://lockerz.com/", "<img id=\"photo\" src=\""}, 
    {"http://instagr.am/",   "<meta property=\"og:image\" content=\""}
  };
}