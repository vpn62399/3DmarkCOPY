# pip install pygame

import socket
import pygame


PORT = 80
BUFFER_SIZE = 1024
HOSTS = ['www.google.com', '192.168.1.20','192.168.1.247']

pygame.mixer.init()
alarm_sound = pygame.mixer.Sound('alarm.wav')

def net(HOST):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(2)
        s.connect((HOST, PORT))
        s.sendall(b'GET / HTTP/1.1\r\n\r\n')
        data = s.recv(BUFFER_SIZE)
        s.close()
        return

while True:
    try:
        for v in HOSTS:
            HOST = v
            net(v)
            pygame.time.wait(500) 
    except:
        print(v)
        alarm_sound.play()
        pygame.time.wait(500)  # 


