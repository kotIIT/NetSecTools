import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_csv('../relative/file/location/output.csv')




#check unique values in column
unique_post = df.post_id.nunique()
print(f"{unique_post} \t\tTotal Unique Posts Found")

#check sum of values in column 
true_count = df["Contains <value>"].sum()

print(f"{true_count} \t Contains <value> ")



print('\n\nDisplaying total flagged comments')


labels = 'y1', 'y2'
Flagged = ['x1','x2',]
plt.pie(Flagged, labels=labels)
plt.title("Titles")

plt.legend(labels, loc=10)
fig1, ax1 = plt.subplots()
ax1.pie(Flagged, labels=labels, autopct='%1.1f%%', startangle=180)
ax1.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circl

