to_print="$( echo '
x  x  xxx   xx  xxxx xxxx    xxx  x  x x   x
x  x x   x x  x x     x     x   x x  x x   x
x  x x     x  x x     x     x     x  x  x x 
x  x  xxx  x  x xxxx  x      xxx  x  x   x  
x  x     x x  x x     x         x x  x  x x 
xxx  x   x x  x x     x     x   x x  x x   x
x     xxx   xx  x     x      xxx   xx  x   x' | sed '1d')"

get_char(){
	echo "$1" | tail -n "+$2" | sed "s/.\\{$3\\}\\(.\\).*/\\1/" | head -n1
}

get_date(){
	date -d "July 15 2017+$(echo "$1+7*($2+5)" | bc) days"
}

useless_commit(){
	echo $1 >> file
	git add file
	GIT_AUTHOR_DATE="$1" GIT_COMMITER_DATE="$1" git commit -am "Hi there! let's pretend the current date is $1"
}

for week in {0..48}; do
	for day in {1..7}; do
		if [ "$(get_char "$to_print" $day $week)" = "x" ]; then
			old_date="$(get_date $day $week)"
			useless_commit "$(date -d "$old_date+1 hour")"
			useless_commit "$(date -d "$old_date+2 hour")"
			useless_commit "$(date -d "$old_date+3 hour")"
			useless_commit "$(date -d "$old_date+4 hour")"
			useless_commit "$(date -d "$old_date+5 hour")"
		fi
	done
done
		

	
