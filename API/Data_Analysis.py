
def analyseData( data, avgHr, std ):
    # input is a list of datapoints[time, heartrate] of n length ordered with newest first

    #sensitivity = 1.3   # Dynamisch maken
    durability = 3

    total = 0
    count = 0
    alerter = 0
    while count < len(data):
        # Calculating base values
        heartRate = data[count]
        count += 1

        # print(heartRate, avg, count)
        maxHr = avgHr * (std/100 + 1)

        if heartRate > maxHr:
            alerter += 1
        else:
            alerter = 0

        # When a alerting heartbeat is measured over mentioned durability a person is in a dream
        if alerter >= durability:
            print("Data line which caused wakeUp -> " + str(count))
            return True

    return False
