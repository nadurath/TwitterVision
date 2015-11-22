import java.util.*;
import twitter4j.*;
import twitter4j.conf.ConfigurationBuilder;

public class TweetCrawler {
	private Twitter twitter;
	
	public TweetCrawler() {
		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setDebugEnabled(true)
		  .setOAuthConsumerKey("aUmPzeBchceTVb9Q5dXdA0Yjv")
		  .setOAuthConsumerSecret("4eLHsF4VXg8YxTbPJdnRR3guo9cfMccLfUwfUxGZ6uIi5kYPdu")
		  .setOAuthAccessToken("2883398341-ZgHWf4W2IncWsOu7oQEC2R0FvOmhxqeMZBJFoXC")
		  .setOAuthAccessTokenSecret("PHoAVJD7W0C3p3uYf4U3rmf7Zp4bRu8Ip1VryhzSYsE6d");
		twitter = new TwitterFactory(cb.build()).getInstance();
	}
	
	public Map<String,String> search(String hashtag) {
        HashMap<String, String> tweetMap = new HashMap<>();
		try {
            Query query = new Query(hashtag);
            QueryResult result;
            int count = 0;
            do {
            	count++;
                result = twitter.search(query);
                for (Status tweet : result.getTweets()) {
                	tweetMap.put("@" + tweet.getUser().getScreenName(), tweet.getText());
                }
            } while ((query = result.nextQuery()) != null && count < 5);
        } catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to search tweets: " + te.getMessage());
        }
		return tweetMap;
	}
	
	public String getPic(String sn) {
		try{
			User current = twitter.users().showUser(sn);
			return current.getOriginalProfileImageURL();
		} catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to find user: " + te.getMessage());
		}
		return "";
	}
}
