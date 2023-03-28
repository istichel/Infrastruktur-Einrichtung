#!/bin/bash
cd;
cd $2;
if [ $1 = 'starten' ]
then
	touch $1
fi
if [ $1 = 'stoppen' ]
then
        kill -9 `lsof -t -i:79`
fi
if [ $1 = 'redeploy' ]
then
        kill -9 `lsof -t -i:79`;
	git pull;
	touch $1;
fi
