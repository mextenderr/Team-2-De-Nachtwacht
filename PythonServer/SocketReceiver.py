import socket

ip = "192.168.8.31"
port = 4567

savedBeats = []

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server.bind((ip, port))
server.listen(1)


while True:
    # Waiting for connection
    clientSocket, clientAddress = server.accept()

    # Receiving data from connected device and storing data in list
    data = clientSocket.recv(1024).decode("utf-8")
    savedBeats.append(data)
    print(savedBeats)
