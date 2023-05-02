# pip install pygame

import socket
import pygame

HOST = 'www.google.com'
PORT = 80
BUFFER_SIZE = 1024

pygame.mixer.init()
alarm_sound = pygame.mixer.Sound('alarm.wav')

while True:
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((HOST, PORT))
        s.sendall(b'GET / HTTP/1.1\r\n\r\n')
        data = s.recv(BUFFER_SIZE)
        s.close()
        pygame.time.wait(5000)  # 
    except:
        alarm_sound.play()
        pygame.time.wait(5000)  # 
