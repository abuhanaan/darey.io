#!/bin/bash

i=1
until [ $i -gt 5 ]
do
    echo "Counting... $i"
    ((i++))
done
