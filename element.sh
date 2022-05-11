#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#echo -e "\n~~~~ Periodic Table ~~~~\n"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    FOUND=$($PSQL "SELECT * FROM elements e INNER JOIN properties p on p.atomic_number = e.atomic_number inner join types t on p.type_id = t.type_id where e.atomic_number=$1; " ) 
  else
    if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
    then
      FOUND=$($PSQL "SELECT *  FROM elements e INNER JOIN properties p on p.atomic_number = e.atomic_number INNER JOIN types t on t.type_id=p.type_id where e.symbol='$1'; " ) 
    else
      if [[ $1 =~ ^[a-zA-Z]+ ]]
      then
        FOUND=$($PSQL "SELECT *  FROM elements e INNER JOIN properties p on p.atomic_number = e.atomic_number INNER JOIN types t on t.type_id=p.type_id where e.name='$1'; " ) 
      fi
    fi
  fi
  # echo $FOUND
  echo "$FOUND" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR BAR BAR BAR BAR ATOM_MASS BAR MELTP BAR BOILP BAR BAR BAR TID BAR TYPE
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELTP celsius and a boiling point of $BOILP celsius."
  done
fi
