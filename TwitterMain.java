import java.io.*;
import java.util.*;
import twitter4j.*;

public class TwitterMain {
	public static void main(String[] args) throws TwitterException {
		String hashtag = "";
		System.out.print("Search a hashtag: ");
		Scanner input = new Scanner(System.in);
		hashtag = input.next();
		input.close();
/*
		 Twitter twitter = TwitterFactory.getSingleton();
		 Query query = new Query(hashtag);
		 QueryResult result;
		 
		try{
			User current = twitter.users().showUser("givethankswoah");
			System.out.println(current.getOriginalProfileImageURL());
		} catch (TwitterException te) {
	           te.printStackTrace();
	           System.out.println("Failed to find user: " + te.getMessage());
		}
		do {
            result = twitter.search(query);
             List<Status> tweets = result.getTweets();
             for (Status tweet : tweets) {
                 System.out.println("@" + tweet.getUser().getScreenName() + " >> " + tweet.getText());
             }
        } while ((query = result.nextQuery()) != null);
*/
		TweetCrawler bug = new TweetCrawler();
		Map<String, String> mappy = bug.search(hashtag);
		if(!mappy.keySet().isEmpty())
			for(String s:mappy.keySet()){
				System.out.println(bug.getPic(s));
				System.out.println(mappy.get(s));
			}
		System.out.println("end");
	}
}
