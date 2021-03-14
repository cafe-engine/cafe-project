#!/bin/bash

git_base=https://github.com/cafe-engine
libs="cafe tea mocha latte coffee"


setup() {
	for lib in $libs; do
		git clone $git_base/$lib --recursive
	done
}

clean() {
	for lib in $libs; do
		make clean -C $lib
		make clean -C cafe/modules/$lib
	done
}

update-mak() {
	for lib in $libs; do
		cp Makefile $lib/Makefile
		cd $lib
		git add Makefile
		git commit -m "update Makefile"
		git push origin main
		cd ..
	done
}

pull() {
	for lib in $libs; do
		cd $lib
		git pull origin main
		cd ..
	done
}

run() {
	./bin/cafe
}

compile() {
	make -C $1
}

case $1 in
setup) setup ;;
clean) clean ;;
update-mak) update-mak ;;
pull) pull ;;
run) run ;;
*) compile $1 ;;
esac

# if [[ $1 == "setup" ]]; then
#   for lib in $libs; do
#       git clone $git_base/$lib --recursive
#   done
# elif [[ $1 == "clean" ]]; then
# 	make clean -C cafe
#   for lib in $libs; do
#   	make clean -C $lib
#     make clean -C cafe/modules/$lib
#   done
# elif [[ $1 == "update" ]]; then
# 	cp Makefile cafe/Makefile
# 	for lib in $libs; do
# 		cp Makefile $lib/Makefile
# 	done
# else
#     make -C cafe
# fi
