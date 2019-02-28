import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt 
import seaborn as sns 
import string 
import string 
import re 
import warnings 


%matplotlib inline

twitter_train = pd.read_csv('E:/Twitter Sentiment analysis/twitter_train.csv')
twitter_test = pd.read_csv('E:/Twitter Sentiment analysis/twitter_test.csv')

combined = twitter_train.append(twitter_test,ignore_index = True)

def remove_user(text,user):
    user_pattern = re.findall(user,text)
    for user in user_pattern:
        text = re.sub(user,'',text)
    return text


#remove twitter @user tags
combined['cleaned_tweet'] = np.vectorize(remove_user)(combined['tweet'],"@[\w]*")

#remove special characters
combined['cleaned_tweet'] = combined['cleaned_tweet'].str.replace("[^a-zA-Z#]"," ")

#Removing small words 
combined['cleaned_tweet'] = combined['cleaned_tweet'].apply(lambda x: ' '.join([w for w in x.split() if len(w)>3]))

#tokenizing the tweets
tokenized_tweet = combined['cleaned_tweet'].apply(lambda x: x.split())

#stemming the tweets
from nltk.stem.porter import *
stemmer = PorterStemmer()
tokenized_tweet = tokenized_tweet.apply(lambda x: [stemmer.stem(i) for i in x])

#Rejoining the tweets 
combined['clean_tweet'] = tokenized_tweet.apply(lambda x: ' '.join(w for w in x))


words = ' '.join([word for word in combined['clean_tweet']])


# Generating the word cloud 
from wordcloud import WordCloud as WC
cloud = WC(width=800,height=500,random_state=21,max_font_size=21).generate(words)

plt.figure(figsize = (10,7))
plt.imshow(cloud,interpolation="bilinear")
plt.axis('off')
plt.show()


# Generating normal words

normal_words = ' '.join([word for word in combined['clean_tweet'][combined['label'] == 0]])
normal_wordcloud = WC(width=800,height=500,random_state=21,max_font_size=110).generate(normal_words)
plt.figure(figsize = (10,7))
plt.imshow(normal_wordcloud,interpolation="bilinear")
plt.axis('off')
plt.show()


# Generating hateful words

normal_words = ' '.join([word for word in combined['clean_tweet'][combined['label'] == 1]])
hateful_wordcloud = WC(width=800,height=500,random_state=21,max_font_size=110).generate(normal_words)
plt.figure(figsize = (10,7))
plt.imshow(hateful_wordcloud,interpolation="bilinear")
plt.axis('off')
plt.show()


#Collecting hashtags 

def hashtag_collector(hashtag):
    hashtags = []
    # Loop over the words in the tweet
    for i in hashtag:
        ht = re.findall(r"#(\w+)", i)
        hashtags.append(ht)

    return hashtags

normal_hashtags = hashtag_collector(combined['clean_tweet'][combined['label'] == 0])

hateful_hashtags = hashtag_collector(combined['clean_tweet'][combined['label'] == 1])


normal_HT = sum(normal_hashtags,[])
hateful_HT = sum(hateful_hashtags,[])

#Plotting frequency distributions 
import nltk
normal_freq = nltk.FreqDist(normal_HT)

normal_dataframe = pd.DataFrame({'Hashtag':list(normal_freq.keys()),
                                 'Frequency':list(normal_freq.values())})


hateful_freq = nltk.FreqDist(hateful_HT)
hateful_dataframe = pd.DataFrame({'Hashtag': list(hateful_freq.keys()), 
                                  'Frequency': list(hateful_freq.values())})


# selecting top 10 most frequent hashtags
normal_dataframe = normal_dataframe.nlargest(columns="Frequency", n = 10)   
plt.figure(figsize=(16,5))
ax = sns.barplot(data=normal_dataframe, x= "Hashtag", y = "Frequency")
ax.set(ylabel = 'Frequency')
plt.show()
    
hateful_dataframe = hateful_dataframe.nlargest(columns="Frequency", n = 10)   
plt.figure(figsize=(16,5))
ax = sns.barplot(data=hateful_dataframe, x= "Hashtag", y = "Frequency")
ax.set(ylabel = 'Frequency')
plt.show()    
    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    