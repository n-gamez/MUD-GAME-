#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <mosquitto.h>

#define MAX_LEN 1024
#define SERVER_PORT 8888
#define MQTT_BROKER ""  //gcp ip 
#define MQTT_PORT 1883
#define MQTT_TOPIC "roomDesc"

char* nextRoom;

void handleKey(const char *key) {
    printf("Received key: %s\n", key);

    char buffer[256];

    if (key[0] == '2') {
        FILE *fp = popen("./north.sh", "r");
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {

            buffer[strcspn(buffer, "\n")] = '\0';
            if (strcmp(buffer, "NO_CHANGE") != 0) {

                nextRoom = strdup(buffer);
                chdir(nextRoom);
                free(nextRoom);
            }
        }
        pclose(fp);
   } else if (key[0] == '4') {
        FILE *fp = popen("./west.sh", "r");
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {

            buffer[strcspn(buffer, "\n")] = '\0';
            if (strcmp(buffer, "NO_CHANGE") != 0) {

                nextRoom = strdup(buffer);
                chdir(nextRoom);
                free(nextRoom);
            }
        }
        pclose(fp);
    } else if (key[0] == '8') {
        FILE *fp = popen("./south.sh", "r");
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {

            buffer[strcspn(buffer, "\n")] = '\0';
            if (strcmp(buffer, "NO_CHANGE") != 0) {
                nextRoom = strdup(buffer);
                chdir(nextRoom);
                free(nextRoom);
            }
        }
        pclose(fp);
    } else if (key[0] == '6') {
        FILE *fp = popen("./east.sh", "r");
        if (fgets(buffer, sizeof(buffer), fp) != NULL) {

            buffer[strcspn(buffer, "\n")] = '\0';
            if (strcmp(buffer, "NO_CHANGE") != 0) {
                nextRoom = strdup(buffer);
                chdir(nextRoom);
                free(nextRoom);
            }
        }
        pclose(fp);
   }
     else {
    }
}

int main() {
    int server_socket, client_socket;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_addr_len = sizeof(client_addr);
    chdir("roomS");
    if ((server_socket = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(SERVER_PORT);

    if (bind(server_socket, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("Binding failed");
        exit(EXIT_FAILURE);
    }
    if (listen(server_socket, 5) == -1) {
        perror("Listening failed");
        exit(EXIT_FAILURE);
    }

    printf("Listening for incoming connections on port %d...\n", SERVER_PORT);

    while (1) {
        if ((client_socket = accept(server_socket, (struct sockaddr *)&client_addr, &client_addr_len)) == -1) {
            perror("Accept failed");
            exit(EXIT_FAILURE);
        }

        printf("Accepted connection from %s:%d\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
        char message[MAX_LEN];
        ssize_t bytes_received;

        while ((bytes_received = recv(client_socket, message, sizeof(message), 0)) > 0) {
            message[bytes_received] = '\0';
            printf("Received message from client: %s\n", message);
            handleKey(message);
        }
        printf("Connection closed by client\n");
        close(client_socket);
    }
    close(server_socket);
    return 0;
}
