# pip install pygame

import socket
import pygame
from time import localtime, strftime


PORT = 80
BUFFER_SIZE = 1024
HOSTS ={'www.google.com':'www.google.com','DHCP':'192.168.1.20','SLAX':'192.168.1.247'}

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
    for v in HOSTS:
        try:
            HOST = HOSTS[v]
            net(HOST)
            pygame.time.wait(500) 
        except:
            tm = strftime("%Y/%m/%d %H:%M:%S", localtime())
            print(v + ' ------ ' + HOSTS[v] + ' ' + tm)
            alarm_sound.play()
            pygame.time.wait(500)  # 
