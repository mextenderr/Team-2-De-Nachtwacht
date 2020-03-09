import socket

ip = "127.0.0.1"
port = 4567

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server.bind((ip, port))
server.listen(1)

clientSocket, clientAddress = server.accept()

while True:
    data = clientSocket.recv(1024).decode("utf-8")
    print(data)
