

all:
	git submodule update --init --recursive
	cd vendor/ashton && bundle install 
	cd vendor/ashton && rake
