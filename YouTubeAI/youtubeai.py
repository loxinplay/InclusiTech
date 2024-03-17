import pandas as pd

import matplotlib.pyplot as plt

from googleapiclient.discovery import build

api_key = 'AIzaSyA-AbQlYVvT9BDzOzRWNv4W5UOiZn71GeQ'
youtube = build('youtube', 'v3', developerKey=api_key)


def search_videos_by_keyword(service, **kwargs):
    search_response = service.search().list(**kwargs).execute()

    videos = []

    for search_result in search_response.get('items', []):
        if search_result['id']['kind'] == 'youtube#video':
            videos.append({
                'Title': search_result['snippet']['title'],
                'Description': search_result['snippet']['description'],
                'URL': f"https://www.youtube.com/watch?v={search_result['id']['videoId']}"
            })

    videos_df = pd.DataFrame(videos)
    return videos_df


keyword = 'How to solve equations'
videos_df = search_videos_by_keyword(youtube, q=keyword, part='id,snippet', maxResults=10)

print(videos_df)

# Let's assume that we have a DataFrame with test results
data = {
    'Day': ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
    'Correct Answers': [7, 8, 9, 6, 10]
}

df = pd.DataFrame(data)

df.plot(kind='bar', x='Day', y='Correct Answers', legend=False)
plt.title('Your progress')
plt.xlabel('Day')
plt.ylabel('Correct answers')
plt.xticks(rotation=0)
plt.show()

# Let's say we have a list with the number of correct answers for each day
correct_answers = [7, 8, 9, 6, 10]
days = range(1, 6)

plt.plot(days, correct_answers, marker='o')
plt.title('Your progress')
plt.xlabel('Day')
plt.ylabel('Correct Answers')
plt.xticks(days)
plt.grid(True)
plt.show()