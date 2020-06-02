import matplotlib.pyplot as plt
import csv

x=[]
y=[]

line = 0
with open('eduard_4302_sleepData.csv', 'r') as csvfile:
    plots= csv.reader(csvfile, delimiter=',')
    itervals = iter(plots)
    next(itervals)
    for row in itervals:
        
        x.append(line)
        y.append(float(row[1]))
        line += 1


plt.plot(x,y, marker='o')

plt.title('Data from the CSV File: People and Expenses')

plt.xlabel('Number of People')
plt.ylabel('Expenses')

plt.show()

