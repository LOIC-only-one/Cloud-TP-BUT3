#!/bin/bash
# Génère du trafic parallèle vers l'API /menu

PARALLEL=10  # Nombre de processus parallèles

for i in $(seq 1 $PARALLEL); do
    while true; do
        curl -s http://192.168.49.2:30080/menu > /dev/null
        sleep 0.1
    done &
done

echo "$PARALLEL générateurs de trafic lancés en arrière-plan."
echo "Utilisez 'pkill curl' pour arrêter tous les processus."
