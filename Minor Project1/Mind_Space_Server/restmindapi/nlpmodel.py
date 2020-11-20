import string
from collections import Counter
import pandas as pd
import matplotlib.pyplot as plt
from nltk.corpus import stopwords
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk.stem import WordNetLemmatizer
from nltk.tokenize import word_tokenize
from PIL import Image


class Senti():
    def __init__(self):

        self.pos=['loved', 'surprise', 'safe', 'surprise', 'adequate', 'focused', 'attracted', 'esteemed', 'entitled', 'happy', 'free', 'ecstatic', 'fearless', 'happy']
        self.neg=['belittled', 'alone', 'derailed', 'lost', 'anxious', 'burdened', 'anger', 'embarrassed', 'obsessed', 'demoralized', 'fear', 'bored', 'sad', 'cheated', 'hated', 'disgust', 'powerless', 'sad', 'apathetic', 'fearful', 'angry']
        self.neu=['lustful', 'singled out', 'neutral', 'attached', 'codependent', 'independent', 'average']
    def sentiment_analyse(self,sentiment_text):
            score = SentimentIntensityAnalyzer().polarity_scores(sentiment_text)
            if score['neu']>score['neg'] and score['neu']>score['pos']:
                return "Neutral"
            if score['neg'] > score['pos']:
                return "Negative"
            elif score['neg'] < score['pos']:
                return "Positive"
            else:
                return "Neutral"
    def clean(self,text):
        lower_case = text.lower()
        cleaned_text = lower_case.translate(str.maketrans('', '', string.punctuation))


        tokenized_words = word_tokenize(cleaned_text, "english")

        final_words = []
        for word in tokenized_words:
            if word not in stopwords.words('english'):
                final_words.append(word)


        lemma_words = []
        for word in final_words:
            word = WordNetLemmatizer().lemmatize(word)
            lemma_words.append(word)

        return lemma_words

    def m1(self,lemma_words):

        emotion_list = []
        di=dict()
        a = '\\'
        with open("D:\Projects\Minor\Minor Project1\Mind_Space_Server"+a+"restmindapi\em.txt", 'r') as file:
            for line in file:
                clear_line = line.replace("\n", '').replace(",", '').replace("'", '').strip()
                word, emotion = clear_line.split(':')
                di[word.strip()]=emotion.strip()
        for i in lemma_words:
            if i in di.keys():
                emotion_list.append(di[i])



        w = Counter(emotion_list)
        w=dict(w)
        w1=dict()
        for i in w.keys():
            w1[i]=(w[i]/sum(w.values()))*100
        return w1

    def graph(self, w):
        fig, ax1 = plt.subplots()
        ax1.bar(w.keys(), w.values())
        fig.autofmt_xdate()
        a="\\"
        plt.savefig('D:\Projects\Minor\mindspace\Assets'+a+'bar.png')
        #g1 = Image.open(r'bar.png')
        #plt.show()
        fig1 = plt.figure(figsize=(6, 6))
        plt.pie(w.values(), labels=w.keys(), autopct='%1.2f%%')
        plt.savefig('D:\Projects\Minor\mindspace\Assets'+a+'pie.png')
        #g2 = Image.open(r'pie.png')
        #im1 = g1.convert('RGB')
        #im2 = g2.convert('RGB')
        #l = [im2]
        #im1.save(r'graph.pdf', save_all=True, append_images=l)

        # show plot
        #plt.show()

    def m2(self,lemma_words):
        a = '\\'
        em=pd.read_csv("D:\Projects\Minor\Minor Project1\Mind_Space_Server"+a+"restmindapi\emotions.csv")
        em=em.set_index('word')

        l=list(em.index)

        count=0
        w=dict()
        for c  in em.columns:
            w[c]=1
        for j in lemma_words:
            if j+' ' in l:
                count +=1
                for i in w.keys():
                    w[i]=w[i]*em[i][j+' ']
        c=dict()

        for i in w.keys():
            c[i]=(w[i]/sum(w.values()))*100
        return c
    def sen_an(self,t):
        score = SentimentIntensityAnalyzer().polarity_scores(t)
        if score['neg'] > score['pos']:
            return "Negative"
        elif score['neg'] < score['pos']:
            return "Positive"
        else:
            return "Neutral"
    
    def final(self,w1,w2,t):
        
        a=self.sentiment_analyse(t)
        a1=self.sen_an(t)
        
        if len(w1)>0:
            m1=max(w1,key=w1.get)
            s1=self.sentiment_analyse(m1)
            if (a==s1 or a1==s1):
                return w1,a
        li=list(w2.values())
        k=list(w2.keys())
        m2=k[li.index(max(li))]
        s2=self.sentiment_analyse(m2)
        if (a==s2 or a1==s2)and li[0]!=1:
            return w2,a
        else:
            return None,a

def nlcheck(t):
    a = Senti()
    l = a.clean(t)  # lemmatized clean list
    if len(l) > 0:
        w1 = a.m1(l)  # model 1
        w2 = a.m2(l)  # modle 2
        w, sent = a.final(w1, w2, t)
        a.graph(w)
    else:
        print(a.sentiment_analyse(t))



nlcheck("hey happy person sad surprise and shocked disgusted alone happy surprised confident and upset")
