import java.util.*;
import twitter4j.*;

public class TweetCrawler {
	private Twitter twitter;
	
	public TweetCrawler() {
		twitter = TwitterFactory.getSingleton();
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
