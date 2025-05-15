#!/bin/bash

read -p 'Enter your first name: ' first_name
read -p 'Enter your last name: ' last_name
read -sp 'Enter your password: ' password
echo
echo "Your first name is $first_name"
echo "Your last name is $last_name"
echo "Your full name is $first_name $last_name"
echo "Your first name has ${#first_name} characters"
echo "Your last name has ${#last_name} characters"
echo "Your full name has $((${#first_name} + ${#last_name})) characters"
echo "Your password is $password"
echo "Your password has ${#password} characters"
echo "Your password is ${password:0:2}****"