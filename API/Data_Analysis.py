
def analyseData( data ):
    # input is a list of datapoints[time, heartrate] of n length ordered with newest first

    sensitivity = 1.3
    durability = 3

    total = 0
    count = 0
    alerter = 0
    while count < len(data):
        # Calculating base values
        heartRate = int(data[count])
        total += int(data[count])
        count += 1
        avg = total / count

        # print(heartRate, avg, count)

        if heartRate > (avg * sensitivity):
            alerter += 1
        else:
            alerter = 0

        # When a alerting heartbeat is measured over mentioned durability a person is in a dream
        if alerter >= durability:
            print(count)
            return True

    return False
